class Phonetic < ApplicationRecord
    has_many :syllable_letter

    has_many :direct_icon_phonetics, :class_name => "IconPhonetic", :foreign_key => :direct_phonetic_id
    has_many :direct_phonetic_icons, :through => :direct_icon_phonetics, :source => :icon

    has_many :undirect_icon_phonetics, :class_name => "IconPhonetic", :foreign_key => :undirect_phonetic_id
    has_many :undirect_phonetic_icons, :through => :undirect_icon_phonetics, :source => :icon
end
