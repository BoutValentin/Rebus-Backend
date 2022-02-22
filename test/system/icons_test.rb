require "application_system_test_case"

class IconsTest < ApplicationSystemTestCase
  setup do
    @icon = icons(:one)
  end

  test "visiting the index" do
    visit icons_url
    assert_selector "h1", text: "Icons"
  end

  test "should create icon" do
    visit icons_url
    click_on "New icon"

    fill_in "Name", with: @icon.name
    click_on "Create Icon"

    assert_text "Icon was successfully created"
    click_on "Back"
  end

  test "should update Icon" do
    visit icon_url(@icon)
    click_on "Edit this icon", match: :first

    fill_in "Name", with: @icon.name
    click_on "Update Icon"

    assert_text "Icon was successfully updated"
    click_on "Back"
  end

  test "should destroy Icon" do
    visit icon_url(@icon)
    click_on "Destroy this icon", match: :first

    assert_text "Icon was successfully destroyed"
  end
end
