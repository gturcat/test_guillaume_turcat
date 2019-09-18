require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'valid user' do
    user = User.new(email: 'toto@gmail.com', password: '123456')
    assert user.valid?
  end

  test 'invalid without password' do
    user = User.new(email: 'toto@gmail.com')
    refute user.valid?, 'user is valid without a name'
    assert_not_nil user.errors[:email], 'no validation error for email present'
  end

  test 'invalid without email' do
    user = User.new(password: '123456')
    refute user.valid?
    assert_not_nil user.errors[:password]
  end
end
