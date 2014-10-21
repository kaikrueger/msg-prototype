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

  def aggregate

    aggregate_type = DeviceType.find_by(name: 'Aggregate')

    Device.where(device_type_id: aggregate_type.id).each { |aggregate_device|

      Sensor.where(device_id: aggregate_device.id).each { |aggregate_sensor|

        timestamps = aggregate_sensor.get_dirty_timestamps!
        measurements = {}

        Device.where(user_id: aggregate_device.user_id).where.not(id: aggregate_device.id)
        .each { |device|

          Sensor.where(device_id: device.id, sensor_type_unit_id: aggregate_sensor.sensor_type_unit.id)
          .each { |sensor|

            timestamps.each { |timestamp|

              value = sensor.get_measurement! timestamp
              unless value
                value = 0
              end

              sum = aggregate_sensor.get_measurement! timestamp
              unless sum
                sum = 0
              end

              sum += value

              aggregate_sensor.remove_measurement! timestamp
              aggregate_sensor.add_measurement! timestamp, sum
              measurements[timestamp] = sum
            }
          }
        }

        channel = aggregate_sensor.channel_key
        WebsocketRails[channel].trigger('load', measurements)

        aggregate_sensor.clear_dirty_timestamps!
      }
    }
    redirect_to 'index'
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
