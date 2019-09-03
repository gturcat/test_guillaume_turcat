class DesksController < ApplicationController
  def index
    @desks = Desk.all
  end

  def show
    @desk = Desk.find(params[:id])
    @bookings = @desk.bookings
    @booking = Booking.new
  end
end
