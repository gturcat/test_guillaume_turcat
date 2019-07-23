class RequestsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create, :show, :confirmation, :reconfirmation]

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)
    if @request.save
      @request.unconfirmed!

      redirect_to request_path(@request)
    else
      render :new
    end
  end

  def show
    @request = Request.find(params[:id])
  end

  def confirmation
    @request = Request.find(params[:id])
    @request.confirmed!
    redirect_to request_path(@request)
  end

  def reconfirmation
    @request = Request.find(params[:id])
    @request.date_status = Date.today
    @request.save
    redirect_to request_path(@request)
  end



  private

  def request_params
    params.require(:request).permit(:name, :email, :phone_number, :bio)
  end
end
