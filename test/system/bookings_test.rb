require "application_system_test_case"

class BookingsTest < ApplicationSystemTestCase

  def setup
    @desk = desks(:desk1)
  end

  test "lets check if calendar display" do
    login_as users(:guillaume)
    visit desk_url(@desk.id)
    assert_selector "#calendar_desk", count: 1
    save_and_open_screenshot
  end

end
