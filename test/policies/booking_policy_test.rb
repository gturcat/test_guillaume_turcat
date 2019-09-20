require 'test_helper'

class BookingPolicyTest < ActiveSupport::TestCase
  def setup
    @guillaume = users(:guillaume)
    @roger = users(:roger)
    @booking_guillaume = bookings(:booking1)
    @booking_roger = bookings(:booking2)
    @booking = Booking.new
    @bookings = Booking.all
  end

  def test_scope
    # assert BookingPolicy.new(@guillaume, @bookings).resolve
    # assert BookingPolicy.new(@roger, @bookings).resolve
  end

  def test_admin?
    assert BookingPolicy.new(@guillaume, @bookings).admin?
    assert_not BookingPolicy.new(@roger, @bookings).admin?
  end

  def test_myreservation?
    assert BookingPolicy.new(@guillaume, @bookings).my_reservations?
    assert BookingPolicy.new(@roger, @bookings).my_reservations?
  end

  def test_pdf_ready?
    assert BookingPolicy.new(@guillaume, @bookings).pdf_ready?
    assert_not BookingPolicy.new(@roger, @bookings).pdf_ready?
  end

  def test_show
    assert BookingPolicy.new(@guillaume, @booking_guillaume).show?
    assert BookingPolicy.new(@guillaume, @booking_roger).show?
    assert BookingPolicy.new(@roger, @booking_roger).show?
    assert_not BookingPolicy.new(@roger, @booking_guillaume).show?
  end

  def test_create
    assert BookingPolicy.new(@guillaume, @booking).create?
    assert BookingPolicy.new(@roger, @booking).create?
  end

end
