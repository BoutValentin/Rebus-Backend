require "test_helper"

class RebusControllerTest < ActionDispatch::IntegrationTest
  test "should get random" do
    get rebus_random_url
    assert_response :success
  end

  test "should get word" do
    get rebus_word_url
    assert_response :success
  end
end
