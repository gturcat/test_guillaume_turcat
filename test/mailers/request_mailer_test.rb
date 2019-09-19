require 'test_helper'

class RequestMailerTest < ActionMailer::TestCase

  def setup
    @request = requests(:guillaume_request)
  end


  test "confirmation" do
    # Create the email and store it for further assertions
    email = RequestMailer.with(request: @request).confirmation

    # Send the email, then test that it got queued
    assert_emails 1 do
      email.deliver_now
    end

    # Test the body of the sent email contains what we expect it to
    assert_equal ['admin@g-turcat.xyz'], email.from
    assert_equal ['gturcat@me.com'], email.to
    assert_equal 'Confirmation Adresse email', email.subject
    puts "email : #{email.body.to_s}"
  end

  test "reconfirmation" do
    # Create the email and store it for further assertions
    email = RequestMailer.with(request: @request).reconfirmation

    # Send the email, then test that it got queued
    assert_emails 1 do
      email.deliver_now
    end

    # Test the body of the sent email contains what we expect it to
    assert_equal ['admin@g-turcat.xyz'], email.from
    assert_equal ['gturcat@me.com'], email.to
    assert_equal 'Merci de confirmer votre intention de nous rejoindre', email.subject
    puts "email : #{email.body.to_s}"
  end

  test "ranking" do
    # Create the email and store it for further assertions
    email = RequestMailer.with(request: @request).ranking

    # Send the email, then test that it got queued
    assert_emails 1 do
      email.deliver_now
    end

    # Test the body of the sent email contains what we expect it to
    assert_equal ['admin@g-turcat.xyz'], email.from
    assert_equal ['gturcat@me.com'], email.to
    assert_equal 'Votre place dans la list d attente', email.subject
    puts "email : #{email.body.to_s}"
  end

    test "confirm_expired" do
    # Create the email and store it for further assertions
    email = RequestMailer.with(request: @request).confirm_expired

    # Send the email, then test that it got queued
    assert_emails 1 do
      email.deliver_now
    end

    # Test the body of the sent email contains what we expect it to
    assert_equal ['admin@g-turcat.xyz'], email.from
    assert_equal ['gturcat@me.com'], email.to
    assert_equal 'Vous avez été retirer de la liste d attente', email.subject
    puts "email : #{email.body.to_s}"
  end

     test "admission" do
    # Create the email and store it for further assertions
    email = RequestMailer.with(request: @request).admission

    # Send the email, then test that it got queued
    assert_emails 1 do
      email.deliver_now
    end

    # Test the body of the sent email contains what we expect it to
    assert_equal ['admin@g-turcat.xyz'], email.from
    assert_equal ['gturcat@me.com'], email.to
    assert_equal 'Welcom aboard', email.subject
    puts "email : #{email.body.to_s}"
  end

end
