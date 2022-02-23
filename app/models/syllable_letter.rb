class SyllableLetter < ApplicationRecord
  belongs_to :phonetic, optional: true

  validates :syllable_letter, presence: true, uniqueness: true

  def get_direct_icon 
    if !self.phonetic.nil? && !self.phonetic.direct_phonetic_icons.nil?
      return self.phonetic.direct_phonetic_icons.sample
    end
    nil
  end
end
