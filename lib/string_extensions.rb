class String 

    # Defined if the string is a single letter and a vowels
    def is_vowels?
        self.length <= 1 && 'aeiouàéèáy'.include?(self) 
    end

    # Check if the string containe some vowels
    # vowels with accent are considere as vowels
    def contains_vowels?
        self.match? 'a|e|i|o|u|à|é|è|á|y'
    end

    # Cut a word into syllable
    # Bateau => [Ba, teau]
    def syllable
        # For each word in the string we cut it in syllable and merge the array
        (self.split(" ").map do |value|
            cut_word(value)
        end).flatten
    end

    # All method above will be private
    private 

    # Cut a word in an array of syllable
    def cut_word(word)
        # We retrieve the idx to where to cut by consonnant
        tab_1 = get_index_consonant(word)
        # We save the word
        checker_word = word
        # We create an empty array to contain syllable cut by consonnant
        word_tab_consonnant = []
        # For each index we found to cut
        # Since we go from the end to the begin, idx will go by DESC
        tab_1.each do |value|
            # We add to the array the cut syllable
            word_tab_consonnant.push(checker_word[value+1...])
            # We update the word by removing the syllable we just push
            checker_word = checker_word[...value+1]
        end
        # We finally add the last syllable and reverse the array
        word_tab_consonnant = word_tab_consonnant.push(checker_word).reverse
        # We remove the syllable with zero vowels in it
        remove_syllabe_with_zero_vowels(word_tab_consonnant)

        # We create an array to save the syllable cut by vowels
        recut_for_vowels = []
        # We create an array who will contain all the correct syllable
        word_tab_vowels = []
        # For each syllable by consonnamt we found
        word_tab_consonnant.each do |w|
            # We cut this syllable by vowels and push it to the array
            recut_for_vowels.push(get_index_vowels(w))
        end
        # For each syllable we found with the recut
        recut_for_vowels.each_with_index do |arr, index|
            # We add to the final array an array
            word_tab_vowels.push([])
            # The current word is the syllable from the cut by consonant with the index
            checker_word = word_tab_consonnant[index]
            # For each syllable in the array
            arr.each do |value|
                # We add to the final array the current syllable cut
                word_tab_vowels[index].push(checker_word[value+1...])
                # We update the current word
                checker_word = checker_word[...value+1]
            end
            # We finally add the last syllable and reverse the array
            word_tab_vowels[index] = word_tab_vowels[index].push(checker_word).reverse
        end
        # For each array contain in the array
        word_tab_vowels.each do |arr|
            # We remove the syllable with zero vowels
            remove_syllabe_with_zero_vowels(arr)
        end
        # We flatten the array to get only syllable
        word_tab_vowels.flatten
    end
    
    # Remove all the syllable who don't have a vowels in it
    def remove_syllabe_with_zero_vowels(tab, index = 0)
        # We retrieve the length of the tab
        tab_l = tab.length
        # If the tab contain only one syllable we return it
        if tab_l <= 1
            return tab
        end
        # If we are at the last position in array
        if index >= tab_l -1 
            # If the syllable doesn't contains any vowels
            if !tab[index].contains_vowels?
                # We join the current idx with the one before
                tab[index-1, index+1] = tab[index-1, index+1].join
            end
            # We return the tab (since the index is already at the end we don't need to go further)
            return tab
        end
        # If the current element in tab doesn't contain any vowels
        if !tab[index].contains_vowels?
            # We merge it with the one after the current
            tab[index, index +2] = tab[index, index+2].join
            # We recall the function with the new tab
            return remove_syllabe_with_zero_vowels(tab)
        end
        # We have to check the other element in array
        remove_syllabe_with_zero_vowels(tab, index+1)
    end

    # We check if the word in begin and end contain some vowels
    def is_good_idx(word, cut_begin, cut_end) 
        word[cut_begin, cut_end].contains_vowels?
    end

    def get_index_vowels_consonant(word, by_vowels = false)
        # We start by the end of the word
        idx = word.length() -1
        # An array of idx to cut 
        to_be_cut_idx = []
        previous_found = false
        # We go through the word
        while idx >= 0
            # We check if the char at idx is a vowels
            res = word[idx].is_vowels?
            # We check if the curr char is good to be cut 
            # If we are by vowels we put res or the reverse
            curr_char_is_good = by_vowels ? res : !res
            # If the current char is waht we search (ie vowels or consonnant)
            # and we previously have found the rules (if we have a vowels and before was a consonnant or if we have a consonnant and previous was also a consonnant )
            if curr_char_is_good && previous_found
                # We push the idx to our array
                to_be_cut_idx.push idx
            end
            # We tell what we found  before
            previous_found = by_vowels ? !curr_char_is_good : curr_char_is_good
            # We move to one char to the right
            idx -= 1
        end
        # We return the array
        to_be_cut_idx
    end

    # Retrieve the next index to cut by vowels
    def get_index_vowels(word)
        get_index_vowels_consonant(word, true)
    end

    # Retrieve the next index to cut by consonant
    def get_index_consonant(word)
        get_index_vowels_consonant(word, false)
    end
end