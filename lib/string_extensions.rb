class String 

    def is_vowels?
        self.length <= 1 && 'aeiouàéèáy'.include?(self) 
    end

    def contains_vowels?
        self.match? 'a|e|i|o|u|à|é|è|á|y'
    end

    def syllable
        (self.split(" ").map do |value|
            cut_word(value)
        end).flatten
    end

    private 

    def cut_word(word)
        tab_1 = get_index_consonant(word)
        checker_word = word
        word_tab_consonnant = []
        tab_1.each do |value|
            word_tab_consonnant.push(checker_word[value+1...])
            checker_word = checker_word[...value+1]
        end
        word_tab_consonnant = word_tab_consonnant.push(checker_word).reverse
        remove_syllabe_with_zero_vowels(word_tab_consonnant)

        recut_for_vowels = []
        word_tab_vowels = []
        word_tab_consonnant.each do |w|
            recut_for_vowels.push(get_index_vowels(w))
        end
        recut_for_vowels.each_with_index do |arr, index|
            word_tab_vowels.push([])
            checker_word = word_tab_consonnant[index]
            arr.each do |value|
                word_tab_vowels[index].push(checker_word[value+1...])
                checker_word = checker_word[...value+1]
            end
            word_tab_vowels[index] = word_tab_vowels[index].push(checker_word).reverse
        end
        word_tab_vowels.each do |arr|
            remove_syllabe_with_zero_vowels(arr)
        end
        word_tab_vowels.flatten
    end
    
    def remove_syllabe_with_zero_vowels(tab, index = 0)
        tab_l = tab.length
        if tab_l <= 1
            return tab
        end
        if index >= tab_l -1 
            if !tab[index].contains_vowels?
                tab[index-1, index+1] = tab[index-1, index+1].join
            end
            return tab
        end
        if !tab[index].contains_vowels?
            tab[index, index +2] = tab[index, index+2].join
            return remove_syllabe_with_zero_vowels(tab)
        end
        remove_syllabe_with_zero_vowels(tab, index+1)
    end

    def is_good_idx(word, cut_begin, cut_end) 
        word[cut_begin, cut_end].contains_vowels?
    end

    def get_index_vowels_consonant(word, by_vowels = false)
        idx = word.length() -1
        to_be_cut_idx = []
        previous_found = false
        while idx >= 0
            res = word[idx].is_vowels?
            curr_char_is_good = by_vowels ? res : !res
            if curr_char_is_good && previous_found
                to_be_cut_idx.push idx
            end
            previous_found = by_vowels ? !curr_char_is_good : curr_char_is_good
            idx -= 1
        end
        to_be_cut_idx
    end

    def get_index_vowels(word)
        get_index_vowels_consonant(word, true)
    end

    def get_index_consonant(word)
        get_index_vowels_consonant(word, false)
    end
end