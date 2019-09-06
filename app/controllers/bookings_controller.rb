class BookingsController < ApplicationController
  def index
    @bookings = policy_scope(Booking).order(created_at: :desc)
  end

  def show
    @booking = Booking.find(params[:id])
    authorize @booking
  end


  def create
    @desk = Desk.find(params[:desk_id])
    @booking = Booking.new(bookings_params)
    authorize @booking
    @booking.desk = @desk
    @booking.user = current_user
    if @booking.save
      redirect_to booking_path(@booking)
    else
      render 'desks/show'
    end
  end

  def bookings_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
