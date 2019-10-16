class DesksController < ApplicationController
  def index # route tested
    @prestations = Prestation.list_prestations.uniq

    # redirection to home pundit
    current_user.request.present? ? @request = current_user.request : @request = Request.new

    # filter with PG_search
    # search =[]
    # if params[:search].present?
    #   search_name = params[:search][:prestations] if params[:search][:prestations] != [""]
    #   search_name.shift
    #   search << search_name
    #   search << params[:search][:query] if params[:search][:query] != ""
    #   @desks = policy_scope(Desk).desk_to_keep(params[:search][:start_date], params[:search][:end_date])
    #   @desks = policy_scope(Desk).global_search(search).order(created_at: :desc) if search.count > 0
    # else
    #   @desks = policy_scope(Desk).order(created_at: :desc)
    # end

    #  filter with arel request
    if params[:search].present?
      search_prestation = params[:search][:prestations]
      search_prestation.shift
      number_of_selected_prestations = search_prestation.count
      base_scope = ->(text){ Prestation.arel_table[:name].matches("%#{text}%")}
      scope = search_prestation.reduce(nil) do |memo, name|
        if memo
          memo.or(base_scope.call(name))
        else
          base_scope.call(name)
        end
      end
      search_address = params[:search][:address]
      search_name = params[:search][:query]
      search_start_date = params[:search][:start_date]
      search_end_sate = params[:search][:end_date]

      @desks = policy_scope(Desk).desk_to_keep(search_start_date, search_end_sate)
      @desks = @desks.near(search_address, 10) if params[:search][:address] != ""
      @desks = @desks.select(Arel.star).where(Desk.arel_table[:name].eq(search_name)) if params[:search][:query] != ""
      @desks = @desks.select(:id, :color, :freedays).joins(:prestations)
          .group(:id)
          .merge(Prestation.where(scope))
          .having(Price.arel_table[:desk_id]
          .count.gteq(number_of_selected_prestations))

    else
      @desks = policy_scope(Desk).order(created_at: :desc)
    end

    # #calcul des taux de remplissage
    @desk_with_remplissge = []
    @desks.each do |desk|
      @desk_with_remplissge << {
        desk: desk,
        remplissage: remplissage(desk),
        price: price(desk),
        prestations: prestations(desk)
      }
    end

    # geocoded
    @desks = @desks.geocoded
    @markers = @desks.map do |desk|
      {
        lat: desk.latitude,
        lng: desk.longitude
      }
    end

  end

  def edit
    @desk = Desk.find(params[:id])
    authorize @desk
  end

  def new
    @desk = Desk.new
    @desk.prices.build.prestations.build
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
    if @desk.update(desks_params)
      redirect_to admin_bookings_path
    else
      render 'edit'
    end
  end

  def set_price
    @desk = Desk.find(params[:id])
    authorize @desk
  end


  private

  def price(desk)
    total_price =[]
    desk.prices.each do |price|
      price.prestations.each do |price_presta|
        total_price << price_presta.detail_price_cents
      end
    end
    total_price.sum
  end

  def prestations(desk)
    total_prestations =[]
    desk.prices.each do |price|
      price.prestations.each do |detail_presta|
        total_prestations << detail_presta.name.capitalize
      end
    end
    total_prestations.uniq
  end

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
    params.require(:desk).permit(:photo, :color, :name, :address,
     prices_attributes: [
      :id,
      :name,
      :detail_price_cents,
      prestations_attributes: [
        :id,
        :name,
        :detail_price_cents,
      ]
    ],
      )
  end

end
