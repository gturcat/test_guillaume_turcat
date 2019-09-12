require 'test_helper'

class RequestsControllerTest < ActionDispatch::IntegrationTest

  test "can create an article" do
    get "/requests/new"
    assert_response :success

    post "/requests",
      params: { request: { name:'turcat', email: 'toto@gmail.com', bio: 'coucoucoucoucouocuoucoucououc', phone_number:'0613072416' } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

end
