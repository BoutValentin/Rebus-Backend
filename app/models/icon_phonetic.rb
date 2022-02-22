class IconPhonetic < ApplicationRecord
  belongs_to :icon

  belongs_to :direct_phonetic, :class_name => "Phonetic", optional: true
  belongs_to :undirect_phonetic, :class_name => "Phonetic", optional: true


  validates :icon, uniqueness: { scope: :direct_phonetic,
    message: "should only have one record for icon and phonetics" }
  validates :icon, uniqueness: { scope: :undirect_phonetic,
      message: "should only have one record for icon and phonetics" }

  validate :presence_of_direct_or_undirect

  validate :not_presence_of_both_direct_or_undirect

  private 
  
    def presence_of_direct_or_undirect
      if direct_phonetic.nil? && undirect_phonetic.nil?
        errors.add(:base, "You should specify at least direct or undirect phonetic")
      end
    end

    def not_presence_of_both_direct_or_undirect
      if !direct_phonetic.nil? && !undirect_phonetic.nil?
        errors.add(:base, "You should specify only one direct or undirect phonetic")
      end
    end
end
