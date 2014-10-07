class SensorsController < ApplicationController
  before_action :signed_in_user, only: [:index]

  def index
    @sensors = Sensor.paginate(page: params[:page])
  end

  def show
    @sensor = Sensor.find(params[:id])
  end

  def edit
    @sensor = Sensor.find(params[:id])
  end

  def update
    @sensor = Sensor.find(params[:id])
    if @sensor.update_attributes(sensor_params)
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

  def sensor_params
    params.require(:sensor).permit(:name, :uuid, :sensor_type_id, :unit_id)
  end

  # Before filters

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: 'Please sign in.'
    end
  end
end
