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

  def header
    skip_authorization
  end

  def show #tested
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def pdf_ready #not tested
    @bookings = policy_scope(Booking).order(created_at: :desc)
    authorize @bookings
    pdf
    # respond_to do |format|
    # pdf_generator
    # format.pdf {
    #     render :pdf => pdf, :layout => 'pdf.html', disposition: 'attachment'
    #   }
    # end
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

  def pdf
    html = render_to_string(action: "pdf_ready", layout: false)
    kit = PDFKit.new(html, page_size: 'A4',
                           footer_center: "Page [page] of [toPage]",
                           layout: false,
                            :"header-html" => header_bookings_path
                           )

    send_data(kit.to_pdf, :filename => 'report.pdf',
                          :type => 'application/pdf',
                          :disposition => 'inline')
  end
end
