require 'test_helper'

class RequestTest < ActiveSupport::TestCase
  def setup
    @request_already_in = requests(:guillaume_request)
    @request = Request.new(name:'turcat', email: 'toto@gmail.com', bio: 'coucoucoucoucouocuoucoucououc', phone_number:'0613072416')
  end

  test 'valid request' do
    assert @request.valid?
  end

  test 'invalid without name' do
    @request.name = nil
    refute @request.valid?, 'request is valid without a name'
    assert_not_nil @request.errors[:name], 'no validation error for email present'
  end

  test 'invalid without email' do
    @request.email = nil
    assert_not_nil @request.errors[:email]
  end

  test 'invalid without bio' do
      @request.bio = nil
      refute @request.valid?
      assert_not_nil @request.errors[:bio]
    end

  test 'invalid without phone number' do
      @request.phone_number = nil
      refute @request.valid?
      assert_not_nil @request.errors[:phone_number]
    end

  test 'invalid short bio' do
      @request.bio = 'toshort'
      refute @request.valid?
      assert_not_nil @request.errors[:bio]
    end

  test 'invalid phone number format' do
    @request.phone_number = '00336130'
    refute @request.valid?
    assert_not_nil @request.errors[:phone_number]
  end

  test 'invalid email because already in base' do
    @request.email = 'gturcat@me.com'
    refute @request.valid?
    assert_not_nil @request.errors[:phone_number]
  end

end
