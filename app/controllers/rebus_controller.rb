require 'httparty'

class RebusController < ApplicationController
  before_action :set_rebus_reponse, only: [:pass, :guess]
  before_action :set_host

  # GET /rebus/random
  def random
    @show_guess = true
    # We do a get request to a third party API
    reponse = HTTParty.get("http://tools.wmflabs.org/anagrimes/hasard.php?langue=fr")
    # We retrieve the word from the last elements
    @word = URI.decode_www_form_component(reponse.request.last_uri.path.split('/').last).split('.').first
    # We create a rebus or retrieve it by the word
    @rebus = create_rebus_if_not_exist(@word)
    # We create a rebus from the word
    rebus_from_word(@word)
    # We render the word template
    render "word"
  end

  # GET /rebus/word?word={word}
  def word
    # For the UI, we tell to not print the guess form (since we are creating a rebus from an already know word)
    @show_guess = false
    # We retrieve from the params the word to cut
    to_cut = params[:word]
    # We put the instance variable word to the to_cut
    @word = to_cut
    # If the word provide is null, we return a json error
    if to_cut.nil?
      render :json => {:error => "You should provide a word for creating a rebus with it"}, status: :bad_request
      return
    end
    # We create a RebusResponse object if it doesn't
    @rebus = create_rebus_if_not_exist(@word)
    # We create a rebus from the word
    rebus_from_word(@word)
  end

  # POST rebus/:id/guess
  def guess
    # We retrive the id from the params
    id = params[:id]
    # If this id is nil
    if id.nil?
      # We return a json error
      render :json => {:error => "You should provide an id to guess a rebus"}, status: :bad_request
      return
    end
    # We retrieve the guess from the parameters
    guess = params[:guess]
    # If the rebus response doesn't exists with the id provide, we render a json error
    if @rebus.nil?
      render :json => {:error => "Incorrect id provide. This rebus doesn't exists."}, status: :not_found
      return
    end
    # We put the default message of incorrect guess
    @message = "Incorrect guess, Please retry"
    # We said also it's an incorrect guess
    @correct = false
    # If the word given is the same as the one from the response
    if guess == @rebus.word
      # We said we found the rebus as message
      @message = "You found the rebus !"
      # We said it's a correct guess
      @correct = true
      # We add to the current log user the point from the rebus
      @current_user.update(points: @rebus.difficulty + @current_user.points)
      # And decrease the difficulty of the rebus since someone find it
      if @rebus.difficulty > 1
        @rebus.update(difficulty: @rebus.difficulty - 1)
      end
    # In case the guess was incorrect, we update the difficulty of the rebus to +1 if it's not already at maximal
    elsif @rebus.difficulty < RebusReponse.MAX_DIFFICULTY
        @rebus.update(difficulty: @rebus.difficulty + 1)
    end
    # We put the new difficulty to the instance variable @difficulty
    @difficulty = @rebus.reload().difficulty
  end

  # POST /rebus/:id/pass
  def pass
    # We retrive the id of the response associate
    id = params[:id]
    # If the id provide is nil
    if id.nil?
      # We return a json error
      render :json => {:error => "You should provide an id to guess a rebus"}, status: :bad_request
      return
    end
    # If the rebus response is nil
    if @rebus.nil?
      # We render a json error
      render :json => {:error => "Incorrect id provide. This rebus doesn't exists."}, status: :not_found
      return
    end
    # We update the difficulty of the rebus response if not already at maximal value
    if @rebus.difficulty < RebusReponse.MAX_DIFFICULTY
      @rebus.update(difficulty: @rebus.difficulty + 1)
    end
    # We return no content, just a 200 response
    head :ok
  end

  private 

  # Helpers method who create a RebusReponse and return it if it doesn't exists by word
  def create_rebus_if_not_exist(word)
    # We try to find a RebusReponse associate with the @word provide
    rebus = RebusReponse.find_by(word: @word)
    # If we don't find any
    if rebus.nil?
      # We create one
      rebus = RebusReponse.create(word: @word, difficulty: RebusReponse.MAX_DIFFICULTY / 2)
    end
    # And return it
    rebus
  end

  # Helpers method who create a rebus from a string word
  def rebus_from_word(word)
    # We put our word to downcase
    word_cut = word.downcase.syllable
    # We first create an instance of @final_syllable which is our array to put icon in it.
    @final_syllable = []
    # We first try to create a rebus with indirect mapping. This means with equation in it.
    create_icon_array(word_cut, @final_syllable, true)
    # We flattent this array
    f_s_flatten = @final_syllable.flatten
    # If this array have a nil value in it
    if (f_s_flatten.include? nil)
      # We retry to create an array without indirect mapping
      @final_syllable = []
      create_icon_array(word_cut, @final_syllable, false)
    end
  end

  # Method who create a mapping from a word cut in syllable as array with an icon
  def create_icon_array(word, array, use_undirect)
    # For each syllable in the word
    word.each do |syllable|
      # We try to map an icon the this syllable
      mapping_icon_syllable(syllable, array, use_undirect)
     end
  end

  # Method who associate an icon to a syllable and add it to the array
  def mapping_icon_syllable(syllable, array, use_undirect = false)
    # We first try to retrieve the syllable in our database
    syllable_db = SyllableLetter.find_by(syllable_letter: syllable)
    # If we don't find any or if this syllable doesn't have any phonetic attach
    if syllable_db.nil? || syllable_db.phonetic.nil?
      # If it's the syllable who is nil
      if syllable_db.nil? 
        # We create a syllable in the db
        SyllableLetter.create(syllable_letter: syllable)
      end
      # We split our syllable into char in order to retrieve an icon for each letter
      syllable.each_char do |letter|
        # We try to find a syllable attach to this letter
        syla = SyllableLetter.find_by(syllable_letter: letter)
        # the icon is at first nil
        icon = nil
        # If we have found a syllable for the letter 
        if !syla.nil?
          # We change the icon to the one provide by letter
          icon = syla.get_direct_icon
        end
        # In any way we push the icon if not nil or just the letter as a char
        array.push(icon.nil? ? letter : icon)
      end
      # We exists the function
      return nil
    end
    
    # We retrieve the phonetic associate to the syllable
    phonetic_db = syllable_db.phonetic
    # We use this boolean to tell if we use direct mapping or not
    use_direct = true
    # If we have both way to represent a syllable with direct and undirect mapping
    if phonetic_db.have_both_direct_undirect_phonetic_icons && use_undirect
      # We make a random between true and false to know if this syllable will be using direct mapping or not
      use_direct = [true, false].sample
    # If we don't have direct mapping by only indirect mapping
    elsif phonetic_db.have_undirect_phonetic_icons && use_undirect
      # We said to only use indirect mapping
      use_direct = false
    end

    # If we have to use direct mapping
    if use_direct
      # We just retrieve a random icon associate to the phonetic
      icon = phonetic_db.direct_phonetic_icons.sample
      # Add this icon to the array if we found it or just the syllable
      array.push(icon.nil? ? syllable : icon)
      # And we leave the function
      return nil
    end
    
    # If we use undirrect mapping we retrieve a random icon to represent the syllable with undirect mapping
    icon_choose = phonetic_db.undirect_phonetic_icons.sample
    # We create an undirect array who will stock all of the other syllable of the equation to be substract
    arr = []
    # For each syllable in the name of the icon
    icon_choose.name.syllable.each do |second_syllable|
      # We are mapping a syllable to an icon (without redirect this time)
      mapping_icon_syllable(second_syllable, arr, false)
    end
    # We push this array of mapping to the array provide in params
    array.push(arr)
  end

  # Allow only a set of parameters to be passed
  def parameters
    params.permit(:word)
  end

  # Helpers method who set the rebus_reponse before passing to the action
  def set_rebus_reponse
    @rebus = RebusReponse.find(params[:id])
  end

  # Helpers method who set the host to use it with URL.
  def set_host
    ActiveStorage::Current.host = request.base_url
  end
end
