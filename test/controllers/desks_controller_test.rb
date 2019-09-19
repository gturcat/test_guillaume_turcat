require 'test_helper'

class DesksControllerTest < ActionDispatch::IntegrationTest
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

  test "should get index" do
    get desks_url
    assert_response :success
  end

  test "should get show" do
    get desk_url(@desk1)
    assert_response :success
  end

  # test "can update an desk" do
  #   patch desk_url(@desk1), params: {desk: { photo: fixture_file_upload('/files/guillaume.jpg', 'image/jpg')} }
  #   puts "#{@desk1.reload.photo}"
  # end

end
