class SensorsController < ApplicationController
  before_action :signed_in_user, only: [:update, :destroy]

  def show
    @sensor = Sensor.find(params[:id])
  end

  def edit
    @sensor = Sensor.find(params[:id])
  end

  def update
    @sensor = Sensor.find(params[:id])

    if SensorPolicy.new(@current_user, @sensor).update?

      if @sensor.update_attributes(sensor_params)
        flash[:success] = 'Sensor updated'
        redirect_to @sensor
      else
        render 'edit'
      end

    else
      flash[:failure] = 'Not authorized.'
      redirect_to devices_path
    end
  end

  def destroy
    @sensor = Sensor.find(params[:id])

    if SensorPolicy.new(@current_user, @sensor).destroy?
      @sensor.destroy
      flash[:success] = 'Sensor deleted.'
      redirect_to devices_path

    else
      flash[:failure] = 'Not authorized.'
      redirect_to devices_path
    end
  end

  private

  def sensor_params
    params.require(:sensor).permit(:name, :uuid, :sensor_type_id, :unit_id, :min_value, :max_value)
  end

  # Before filters

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: 'Please sign in.'
    end
  end
end
