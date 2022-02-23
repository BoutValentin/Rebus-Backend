class RebusController < ApplicationController
  before_action do
    ActiveStorage::Current.host = request.base_url
  end

  def random
  end

  def word
    to_cut = params[:word]
    if to_cut.nil?
      render :json => {:error => "You should provide a word for creating a rebus with it"}, status: :bad_request
    end
    @word_cut = to_cut.syllable
    @final_syllable = []
    create_icon_array(@word_cut, @final_syllable, true)
    f_s_flatten = @final_syllable.flatten
    if (f_s_flatten.include? nil)
      @final_syllable = []
      create_icon_array(@word_cut, @final_syllable, false)
    end
    @final_syllable
  end

  private 

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
end
