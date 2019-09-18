require "application_system_test_case"

class DesksTest < ApplicationSystemTestCase
  test "lets a signed in user check the index of desks" do
    login_as users(:guillaume)
    visit "/desks"
    assert_selector ".card-product", count: Desk.count
    save_and_open_screenshot
  end
end
