require 'test_helper'

class RequestsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @guillaume_request = requests(:guillaume_request)
  end

  test "can create an booking" do
    get "/requests/new"
    assert_response :success

    post "/requests",
      params: { request: { name:'turcat', email: 'toto@gmail.com', bio: 'coucoucoucoucouocuoucoucououc', phone_number:'0613072416' } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

 test "should get show" do
    get request_url(@guillaume_request)
    assert_response :success
  end

  test "should get confirmation" do
    get confirmation_request_url(id: @guillaume_request.id)
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test "should get reconfirmation" do
    get reconfirmation_request_url(id: @guillaume_request.id)
    assert_response :redirect
    follow_redirect!
    assert_response :success

  end

  test "should confirmation confirm" do
    get confirmation_request_url(id: @guillaume_request.id)
    puts "#{@guillaume_request.status}"
    puts "#{@guillaume_request.reload.status}"
    assert(@guillaume_request.reload.confirmed?)
  end

  test "should reconfirmation change the status_date at today" do
    get reconfirmation_request_url(id: @guillaume_request.id)
    assert_equal(Date.today,@guillaume_request.reload.date_status )
  end


end
