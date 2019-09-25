class DesksController < ApplicationController
  def index # route tested
    current_user.request.present? ? @request = current_user.request : @request = Request.new
    @desk_with_remplissge = []
    @desks = policy_scope(Desk).order(created_at: :desc)
    @desks.each do |desk|
      @desk_with_remplissge << {
        desk: desk,
        remplissage: remplissage(desk)
      }
    end
  end

  def new
    @desk = Desk.new
    @desk.prices.build
    authorize @desk
  end

  def create
    @desk = Desk.new(desks_params)
    authorize @desk
    if @desk.save
      redirect_to admin_bookings_path
    else
      render :new
    end
  end

  def show # route tested
    @desk = Desk.find(params[:id])
    @bookings = @desk.bookings
    @booking = Booking.new
    authorize @desk
  end

  def update
    @desk = Desk.find(params[:id])
    authorize @desk
    @desk.update(desks_params)
    redirect_to admin_bookings_path
  end

  def set_price
    @desk = Desk.find(params[:id])
    authorize @desk
  end


  private

  def remplissage(desk)
    total_days = 0
    # current_bookings =  Booking.booking_of_next_seven_day.where(desk: desk)
    current_bookings =  Booking.booking_of_next_seven_day.where(Booking.arel_table[:desk_id].eq(desk.id))
    old_bookings = Booking.previous_booking.where(Booking.arel_table[:desk_id].eq(desk.id))
    date_ranges = old_bookings.map { |b| b.start_date..b.end_date }

    date_ranges.each do |range|
      if range.include? Date.today
        total_days += (range.last - Date.today).to_i + 1 > 7 ? 7 : (range.last - Date.today).to_i
      end
    end

    current_bookings.each do |booking|
      total_days += (booking.end_date - booking.start_date).to_i + 1 > 7 ? 7 : (booking.end_date - booking.start_date).to_i + 1
    end
  return (7 - total_days)
  end

  def desks_params
    params.require(:desk).permit(:photo, prices_attributes: [ :id, :name, :detail_price_cents ])
  end

end
