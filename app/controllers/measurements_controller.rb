class MeasurementsController < ApplicationController

  def create
    measurement = {sensor_uuid: params[:sensor_uuid], timestamp: params[:timestamp], value: params[:value]}

    channel = "sensor-#{params[:sensor_uuid]}"
    WebsocketRails[channel].trigger('create', measurement)
    render json: {message: 'Measurement created'}

    sensor = Sensor.find_by(uuid: params[:sensor_uuid])
    sensor.add_measurement! params[:timestamp], params[:value]
  end

  def update
    measurement = {sensor_uuid: params[:sensor_uuid], timestamp: params[:timestamp], value: params[:value]}

    channel = "sensor-#{params[:sensor_uuid]}"
    WebsocketRails[channel].trigger('update', measurement)
    render json: {message: 'Measurement updated'}

    sensor = Sensor.find_by(uuid: params[:sensor_uuid])
    sensor.add_measurement! params[:timestamp], params[:value]
  end

  def destroy
    measurement = {sensor_uuid: params[:sensor_uuid], timestamp: params[:timestamp]}

    channel = "sensor-#{params[:sensor_uuid]}"
    WebsocketRails[channel].trigger('destroy', measurement)
    render json: {message: 'Measurement destroyed'}

    sensor = Sensor.find_by(uuid: params[:sensor_uuid])
    sensor.remove_measurement! params[:timestamp]
  end

  private

  def measurement_params
    params.require(:measurement).permit(:sensor_uuid, :timestamp, :value)
  end
end