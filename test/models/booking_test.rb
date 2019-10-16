require 'test_helper'

class BookingTest < ActiveSupport::TestCase
  def setup
    @user = users(:guillaume)
    @desk = desks(:desk1)
    @desk2 = desks(:desk2)
    @booking1 = bookings(:booking1)
    @booking2 = bookings(:booking2)
    @booking3 = bookings(:booking3)
    @booking = Booking.new(start_date: '12/09/2019', end_date: '14/09/2019', user: @user, desk: @desk)
  end

  test 'valid booking' do
    assert @booking.valid?
  end

  test 'invalid without desk' do
    @booking.desk = nil
    refute @booking.valid?
  end


  test 'invalid without user' do
    @booking.user = nil
    refute @booking.valid?
  end

  test 'invalid without start_date' do
    @booking.start_date = nil
    refute @booking.valid?
  end

  test 'invalid without end_date' do
    @booking.end_date = nil
    refute @booking.valid?
  end

  test 'invalid if date alrady taken1' do
    @booking.start_date = '09/09/2019'
    refute @booking.valid?
  end

  test 'invalid if date alrady taken2' do
    @booking.end_date = '17/09/2019'
    refute @booking.valid?
  end

  test 'invalid if date alrady taken3' do
    @booking.start_date = '06/09/2019'
    @booking.end_date = '13/09/2019'
    refute @booking.valid?
  end

  test 'valid freedays' do
    @booking.desk = @desk2
    @booking.send(:calculate_freedays_to_concerned_desk)
    assert_equal(28, @booking.desk.freedays )
  end

end
