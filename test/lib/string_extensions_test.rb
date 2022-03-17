# We require the string extension to test in it
require_relative '../../lib/string_extensions.rb'

# Test the string extension
class StringExtensionsTest < ActiveSupport::TestCase

    test "is correct vowels" do
        ['a', 'e', 'i', 'o', 'u', 'y'].each do |letter|
            assert letter.is_vowels?
        end
    end

    test 'is incorrect vowels' do 
        ['b','c','d','f','g', 'k', 'm'].each do |letter|
            assert_not letter.is_vowels?
        end
    end

    test 'string contains vowels' do 
        ['bateau', 'avion', 'camion', 'benne', 'ordinateur', 'clavier'].each do |word|
            assert word.contains_vowels?
        end
    end

    test 'string dont contains vowels' do 
        ['rtwlcm', 'vdwwng', 'qplcv', 'nnvnvs', 'qpfbv', 'wpvncb'].each do |word|
            assert_not word.contains_vowels?
        end
    end

    test "wrap syllable" do
        [['bateau', ['ba', 'teau']], ['avion', ['a', 'vion']], ['camion', ['ca', 'mion']], ['benne', ['ben', 'ne']], ['ordinateur', ['or', 'di', 'na', 'teur']], ['clavier', ['cla', 'vier']] ].each do |tab|
            word = tab[0]
            syllable_wait = tab[1]
            assert_equal(word.syllable, syllable_wait)
        end
    end
end