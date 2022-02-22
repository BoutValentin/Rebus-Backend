require "application_system_test_case"

class PhoneticsTest < ApplicationSystemTestCase
  setup do
    @phonetic = phonetics(:one)
  end

  test "visiting the index" do
    visit phonetics_url
    assert_selector "h1", text: "Phonetics"
  end

  test "should create phonetic" do
    visit phonetics_url
    click_on "New phonetic"

    fill_in "Phonetic", with: @phonetic.phonetic
    click_on "Create Phonetic"

    assert_text "Phonetic was successfully created"
    click_on "Back"
  end

  test "should update Phonetic" do
    visit phonetic_url(@phonetic)
    click_on "Edit this phonetic", match: :first

    fill_in "Phonetic", with: @phonetic.phonetic
    click_on "Update Phonetic"

    assert_text "Phonetic was successfully updated"
    click_on "Back"
  end

  test "should destroy Phonetic" do
    visit phonetic_url(@phonetic)
    click_on "Destroy this phonetic", match: :first

    assert_text "Phonetic was successfully destroyed"
  end
end
