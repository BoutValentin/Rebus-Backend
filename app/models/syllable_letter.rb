class SyllableLetter < ApplicationRecord
  belongs_to :phonetic, optional: true

  validates :syllable_letter, presence: true
  
end
