class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
  end


  def create
    @desk = Desk.find(params[:desk_id])
    @booking = Booking.new(bookings_params)
    @booking.desk = @desk
    @booking.user = current_user
    if @booking.save
      redirect_to booking_path(@booking)
    else
      raise
      render 'desks/show'
    end
  end

  def bookings_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
