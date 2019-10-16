# require 'test_helper'

# class UserMailerTest < ActionMailer::TestCase

# def setup
#     @message = message(:guillaume_message)
# end
#  test "message_perso" do
#   # Create the email and store it for further assertions
#     email = UserMailer.with(request: @message).message_perso

#     # Send the email, then test that it got queued
#     assert_emails 1 do
#       email.deliver_now
#     end

#     # Test the body of the sent email contains what we expect it to
#     assert_equal ['gturcat@me.com'], email.from
#     assert_equal ['gturcat@me.com'], email.to
#     assert_equal 'coucou', email.subject
#     puts "email : #{email.body.to_s}"
#   end

# end
