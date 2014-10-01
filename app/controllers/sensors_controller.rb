class SensorsController < ApplicationController
  before_action :signed_in_user, only: [:index]

  def index
    @sensors = Sensor.paginate(page: params[:page])
  end

  def show
    @sensor = Sensor.find(params[:id])
  end


  private

  # Before filters

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end
end
