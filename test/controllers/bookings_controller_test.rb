require 'test_helper'

class BookingsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    sign_in users(:guillaume)
    @guillaume = users(:guillaume)
    @roger = users(:roger)
    @desk1 = desks(:desk1)
    @desk2 = desks(:desk2)
    @booking1 = bookings(:booking1)
    @booking2 = bookings(:booking2)
  end

  test "should get admin" do
    get admin_bookings_url
    assert_response :success
  end

  test "should get Myreservation" do
    get my_reservations_bookings_url
    assert_response :success
  end

  test "should get show" do
    get booking_url(@booking1)
    assert_response :success
  end

  test "can create a booking" do
    post desk_bookings_url(desk_id: @desk1.id), params: { booking: {start_date: "19/09/2020", end_date: "20/09/2020"} }
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test "should get pdf_ready" do
    get pdf_ready_bookings_url format: :pdf
    assert_response :success
    assert_equal "application/pdf", response.content_type
  end


end
