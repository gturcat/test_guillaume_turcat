class DesksController < ApplicationController
  def index
    @desks = policy_scope(Desk).order(created_at: :desc)
  end

  def show
    @desk = Desk.find(params[:id])
    @bookings = @desk.bookings
    @booking = Booking.new
    authorize @desk
  end
end
