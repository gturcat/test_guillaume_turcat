require "application_system_test_case"

class RequestsTest < ApplicationSystemTestCase
include ActionMailer::TestHelper

  test "lets make a request and waiting for email" do
    visit "/"
    page.fill_in('request[name]', with: 'Dupond')
    page.fill_in('request[email]', with: 'roger200@me.com')
    page.fill_in('request[phone_number]', with: '0623072416')
    page.fill_in('request[bio]', with: 'jdoiazjdoiajzdiojaodjaiojdioajdiojaiozdjazdoaizjdzd')

    assert_enqueued_emails 1 do
      click_on 'Valider'
    end
    save_and_open_screenshot
  end
end
