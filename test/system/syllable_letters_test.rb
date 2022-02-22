require "application_system_test_case"

class SyllableLettersTest < ApplicationSystemTestCase
  setup do
    @syllable_letter = syllable_letters(:one)
  end

  test "visiting the index" do
    visit syllable_letters_url
    assert_selector "h1", text: "Syllable letters"
  end

  test "should create syllable letter" do
    visit syllable_letters_url
    click_on "New syllable letter"

    fill_in "Phonetic", with: @syllable_letter.phonetic_id
    fill_in "Syllable letter", with: @syllable_letter.syllable_letter
    click_on "Create Syllable letter"

    assert_text "Syllable letter was successfully created"
    click_on "Back"
  end

  test "should update Syllable letter" do
    visit syllable_letter_url(@syllable_letter)
    click_on "Edit this syllable letter", match: :first

    fill_in "Phonetic", with: @syllable_letter.phonetic_id
    fill_in "Syllable letter", with: @syllable_letter.syllable_letter
    click_on "Update Syllable letter"

    assert_text "Syllable letter was successfully updated"
    click_on "Back"
  end

  test "should destroy Syllable letter" do
    visit syllable_letter_url(@syllable_letter)
    click_on "Destroy this syllable letter", match: :first

    assert_text "Syllable letter was successfully destroyed"
  end
end
