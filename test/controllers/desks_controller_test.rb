require 'test_helper'

class DesksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get desks_index_url
    assert_response :success
  end

end
