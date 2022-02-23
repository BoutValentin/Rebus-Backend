class Phonetic < ApplicationRecord
    has_many :syllable_letter

    has_many :direct_icon_phonetics, :class_name => "IconPhonetic", :foreign_key => :direct_phonetic_id
    has_many :direct_phonetic_icons, :through => :direct_icon_phonetics, :source => :icon

    has_many :undirect_icon_phonetics, :class_name => "IconPhonetic", :foreign_key => :undirect_phonetic_id
    has_many :undirect_phonetic_icons, :through => :undirect_icon_phonetics, :source => :icon


    def have_both_direct_undirect_phonetic_icons
        self.have_direct_phonetic_icons & self.have_undirect_phonetic_icons
    end

    def have_direct_phonetic_icons
        !self.direct_phonetic_icons.empty?
    end 

    def have_undirect_phonetic_icons
        !self.undirect_phonetic_icons.empty?
    end
end
