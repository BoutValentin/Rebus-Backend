require 'httparty'

class RebusController < ApplicationController
  before_action :set_rebus_reponse, only: [:pass, :guess]
  before_action :set_host

  def random
    reponse = HTTParty.get("http://tools.wmflabs.org/anagrimes/hasard.php?langue=fr")
    @word = URI.decode_www_form_component(reponse.request.last_uri.path.split('/').last)
    @rebus = create_rebus_if_not_exist(@word)
    rebus_from_word(@word)
    render "word"
  end

  def word
    to_cut = params[:word]
    @word = to_cut
    if to_cut.nil?
      render :json => {:error => "You should provide a word for creating a rebus with it"}, status: :bad_request
    end
    @rebus = create_rebus_if_not_exist(@word)
    rebus_from_word(@word)
    @word = to_cut
  end

  def guess
    id = params[:id]
    if id.nil?
      render :json => {:error => "You should provide an id to guess a rebus"}, status: :bad_request
      return
    end
    guess = params[:guess]
    if @rebus.nil?
      render :json => {:error => "Incorrect id provide. This rebus doesn't exists."}, status: :not_found
      return
    end
    @message = "Incorrect guess, Please retry"
    @correct = false
    if guess == @rebus.word
      @message = "You found the rebus !"
      @correct = true
      if @rebus.difficulty > 0
        @rebus.update(difficulty: @rebus.difficulty - 1)
      end
    elsif @rebus.difficulty < RebusReponse.MAX_DIFFICULTY
        @rebus.update(difficulty: @rebus.difficulty + 1)
    end
    @difficulty = @rebus.reload().difficulty
  end

  def pass
    id = params[:id]
    if id.nil?
      render :json => {:error => "You should provide an id to guess a rebus"}, status: :bad_request
      return
    end
    if @rebus.nil?
      render :json => {:error => "Incorrect id provide. This rebus doesn't exists."}, status: :not_found
      return
    end
    if @rebus.difficulty < RebusReponse.MAX_DIFFICULTY
      @rebus.update(difficulty: @rebus.difficulty + 1)
    end
    head :ok
  end

  private 

  def create_rebus_if_not_exist(word)
    rebus = RebusReponse.find_by(word: @word)
    if rebus.nil?
      rebus = RebusReponse.create(word: @word, difficulty: 0)
    end
    rebus
  end

  def rebus_from_word(word)
    word_cut = word.downcase.syllable
    @final_syllable = []
    create_icon_array(word_cut, @final_syllable, true)
    f_s_flatten = @final_syllable.flatten
    if (f_s_flatten.include? nil)
      @final_syllable = []
      create_icon_array(word_cut, @final_syllable, false)
    end
  end

  def create_icon_array(word, array, use_undirect)
    word.each do |syllable|
      mapping_icon_syllable(syllable, array, use_undirect)
     end
  end

  def mapping_icon_syllable(syllable, array, use_undirect = false)
    syllable_db = SyllableLetter.find_by(syllable_letter: syllable)
    if syllable_db.nil? || syllable_db.phonetic.nil?
      if syllable_db.nil? 
        SyllableLetter.create(syllable_letter: syllable)
      end
      syllable.each_char do |letter|
        icon = SyllableLetter.find_by(syllable_letter: letter).get_direct_icon
        array.push(icon.nil? ? letter : icon)
      end
      return nil
    end
    
    phonetic_db = syllable_db.phonetic
    use_direct = true
    if phonetic_db.have_both_direct_undirect_phonetic_icons && use_undirect
      use_direct = [true, false].sample
    elsif phonetic_db.have_undirect_phonetic_icons && use_undirect
      use_direct = false
    end

    if use_direct
      icon = phonetic_db.direct_phonetic_icons.sample
      array.push(icon.nil? ? syllable : icon)
      return nil
    end
    
    icon_choose = phonetic_db.undirect_phonetic_icons.sample
    arr = []
    icon_choose.name.syllable.each do |second_syllable|
      mapping_icon_syllable(second_syllable, arr, false)
    end
    array.push(arr)
  end

  def parameters
    params.permit(:word)
  end

  def set_rebus_reponse
    @rebus = RebusReponse.find(params[:id])
  end

  def set_host
    ActiveStorage::Current.host = request.base_url
  end
end
