require 'test_helper'

class UsermailerMailerTest < ActionMailer::TestCase
  test "message_perso" do
    mail = UsermailerMailer.message_perso
    assert_equal "Message perso", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
