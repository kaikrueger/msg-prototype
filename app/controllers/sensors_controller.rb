class SensorsController < ApplicationController
  before_action :signed_in_user, only: [:index]

  def index
    @sensors = Sensor.paginate(page: params[:page])
  end

  def show
    @sensor = Sensor.find(params[:id])
  end

  def edit
  end

  def update
    if @sensor.update_attributes(user_params)
      flash[:success] = 'Sensor updated'
      redirect_to @sensor
    else
      render 'edit'
    end
  end

  def destroy
    Sensor.find(params[:id]).destroy
    flash[:success] = 'Sensor deleted.'
    redirect_to sensors_url
  end

  private

  def user_params
    params.require(:sensor).permit(:name, :uuid)
  end

  # Before filters

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: 'Please sign in.'
    end
  end
end
