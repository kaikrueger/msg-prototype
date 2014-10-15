class StaticPagesController < ApplicationController
  before_action :signed_in_user, only: [:dashboard]
  helper_method :get_aggregate_sensor

  def home
  end

  def help
  end

  def about
  end

  def contact
  end

  def dashboard
  end

  def get_aggregate_sensor(type_name)

    unit = Unit.find_by(symbol: 'W')
    aggregate_type = DeviceType.find_by(name: 'Aggregate')
    sensor_type = SensorType.find_by(name: type_name)
    sensor_type_unit = SensorTypeUnit.find_by(sensor_type_id: sensor_type.id, unit_id: unit.id)
    device = Device.find_by(device_type_id: aggregate_type.id, user_id: @current_user.id)

    if device
      Sensor.find_by(device_id: device.id, sensor_type_unit_id: sensor_type_unit.id)
    else
      nil
    end
  end

  private

  # Before filters

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: 'Please sign in.'
    end
  end
end
