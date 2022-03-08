class RebusReponse < ApplicationRecord
    validates :word, presence: true, uniqueness: true
    
    def self.MAX_DIFFICULTY
        50
    end
end
