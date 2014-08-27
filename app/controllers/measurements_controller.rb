class MeasurementsController < ApplicationController

  def create
    measurement = {sensor_id: params[:sensor_id], timestamp: params[:timestamp], value: params[:value]}
    WebsocketRails['measurements'].trigger('create', measurement)
    render json: {message: 'Measurement created'}
  end

  def update
    measurement = {sensor_id: params[:sensor_id], timestamp: params[:timestamp], value: params[:value]}
    WebsocketRails['measurements'].trigger('update', measurement)
    render json: {message: 'Measurement updated'}
  end

  def destroy
    measurement = {sensor_id: params[:sensor_id], timestamp: params[:timestamp]}
    WebsocketRails['measurements'].trigger('destroy', measurement)
    render json: {message: 'Measurement destroyed'}
  end

  private

  def measurement_params
    params.require(:measurement).permit(:timestamp, :value)
  end
end