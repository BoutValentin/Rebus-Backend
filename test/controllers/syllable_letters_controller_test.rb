require "test_helper"

class SyllableLettersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @syllable_letter = syllable_letters(:one)
  end

  test "should get index" do
    get syllable_letters_url
    assert_response :success
  end

  test "should get new" do
    get new_syllable_letter_url
    assert_response :success
  end

  test "should create syllable_letter" do
    assert_difference("SyllableLetter.count") do
      post syllable_letters_url, params: { syllable_letter: { phonetic_id: @syllable_letter.phonetic_id, syllable_letter: @syllable_letter.syllable_letter } }
    end

    assert_redirected_to syllable_letter_url(SyllableLetter.last)
  end

  test "should show syllable_letter" do
    get syllable_letter_url(@syllable_letter)
    assert_response :success
  end

  test "should get edit" do
    get edit_syllable_letter_url(@syllable_letter)
    assert_response :success
  end

  test "should update syllable_letter" do
    patch syllable_letter_url(@syllable_letter), params: { syllable_letter: { phonetic_id: @syllable_letter.phonetic_id, syllable_letter: @syllable_letter.syllable_letter } }
    assert_redirected_to syllable_letter_url(@syllable_letter)
  end

  test "should destroy syllable_letter" do
    assert_difference("SyllableLetter.count", -1) do
      delete syllable_letter_url(@syllable_letter)
    end

    assert_redirected_to syllable_letters_url
  end
end
