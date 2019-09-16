class RequestsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create, :show, :confirmation, :reconfirmation]

  def new #tested
    @request = Request.new
    skip_authorization
  end

  def create #tested
    @request = Request.new(request_params)
    if @request.save
      @request.unconfirmed! #il veut mieux mettre une valeur par defaut

      redirect_to request_path(@request)
    else
      render :new
    end
    skip_authorization
  end

  def show #tested
    @request = Request.find(params[:id])
    skip_authorization
  end

  def confirmation #tested
    @request = Request.find(params[:id])
    @request.confirmed!
    redirect_to request_path(@request)
    skip_authorization
  end

  def reconfirmation #tested
    @request = Request.find(params[:id])
    @request.date_status = Date.today
    @request.save
    redirect_to request_path(@request)
    skip_authorization
  end


  private

  def request_params
    params.require(:request).permit(:name, :email, :phone_number, :bio)
  end
end
