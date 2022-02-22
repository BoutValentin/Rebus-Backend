class Icon < ApplicationRecord
  has_one_attached :image

  has_many :icon_phonetics
  has_many :direct_phonetics, through: :icon_phonetics, source: :direct_phonetic
  has_many :undirect_phonetics, through: :icon_phonetics, source: :undirect_phonetic

  def phonetics
    self.direct_phonetics + self.undirect_phonetics
  end
end
