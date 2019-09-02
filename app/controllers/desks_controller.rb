class DesksController < ApplicationController
  def index
    @desks = Desk.all
  end

  def show
    @desk = Desk.find(params[:id])
  end
end
