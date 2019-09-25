class BookingsController < ApplicationController
  def index
    @bookings = policy_scope(Booking).order(created_at: :desc)
    @desks = policy_scope(Desk).order(created_at: :desc)
  end

  def admin #tested
    @bookings = policy_scope(Booking).order(created_at: :desc)
    @desks = Desk.paginate(page: params[:page], per_page: 1)
    authorize @bookings
    # respond_to do |format| # specifier uniquement quand on doit préciser un comportement non standard
    #   format.html # index.html.erb
    #   format.js
    # end
  end

  def my_reservations #routes tested
    @bookings = policy_scope(Booking).order(created_at: :desc)
    @desks = policy_scope(Desk).order(created_at: :desc)
    authorize @bookings
  end


  def show #tested
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def pdf_ready #not tested
    @bookings = policy_scope(Booking).order(created_at: :desc)
    authorize @bookings
    respond_to do |format|
    format.pdf {
        render :pdf => "pdf_ready", :layout => 'pdf.html', disposition: 'attachment'
      }
    end
  end

  def create #tested
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

  def import
    Booking.my_import(params[:file])
    authorize Booking
    redirect_to admin_bookings_path, notice: "Data imported!"
  end

  private

  def bookings_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
