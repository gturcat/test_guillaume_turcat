require "application_system_test_case"

class BookingsTest < ApplicationSystemTestCase

  def setup
    login_as users(:guillaume)
    @desk = desks(:desk1)
  end

  test "lets check if calendar display" do
    visit desk_url(@desk.id)
    assert_selector "#calendar_desk", count: 1
    # save_and_open_screenshot
  end

  test "lets booking via calendar" do
    visit desk_url(@desk.id)
    # page.fill_in('booking[start_date]', with: '29/09/2019')
    # page.fill_in('booking[end_date]', with: '02/10/2019')
    page.execute_script("document.getElementById('booking_start_date').value = '29/09/2019';
          document.getElementById('booking_end_date').value = '02/10/2019';")
    page.execute_script("document.getElementById('bookbtn').disabled = false;")
    click_button('Réserver')
    puts "booking id :#{Booking.last.id}"
    save_and_open_screenshot
    assert_equal booking_path(Booking.last.id), page.current_path
  end

end
