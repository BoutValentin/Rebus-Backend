require "test_helper"

class PhoneticsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @phonetic = phonetics(:one)
  end

  test "should get index" do
    get phonetics_url
    assert_response :success
  end

  test "should get new" do
    get new_phonetic_url
    assert_response :success
  end

  test "should create phonetic" do
    assert_difference("Phonetic.count") do
      post phonetics_url, params: { phonetic: { phonetic: @phonetic.phonetic } }
    end

    assert_redirected_to phonetic_url(Phonetic.last)
  end

  test "should show phonetic" do
    get phonetic_url(@phonetic)
    assert_response :success
  end

  test "should get edit" do
    get edit_phonetic_url(@phonetic)
    assert_response :success
  end

  test "should update phonetic" do
    patch phonetic_url(@phonetic), params: { phonetic: { phonetic: @phonetic.phonetic } }
    assert_redirected_to phonetic_url(@phonetic)
  end

  test "should destroy phonetic" do
    assert_difference("Phonetic.count", -1) do
      delete phonetic_url(@phonetic)
    end

    assert_redirected_to phonetics_url
  end
end
