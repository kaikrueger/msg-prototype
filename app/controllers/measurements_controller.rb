class MeasurementsController < WebsocketRails::BaseController

  def initialize_session
    # Initialize controller
  end

  def connect_client
    # New client connected
  end

  def disconnect_client
    # Client disconnected
  end

  def load_measurements

    sensor = Sensor.find_by(uuid: message[:sensor_uuid])
    measurements = sensor.get_all_measurements!

    channel = sensor_channel_key message[:sensor_uuid]
    WebsocketRails[channel].trigger('load', measurements)

    send_message :load_success, 'load_success', :namespace => :measurements
  end

  def post_measurement

    measurement = {sensor_uuid: message[:sensor_uuid], timestamp: message[:timestamp], value: message[:value]}

    channel = sensor_channel_key message[:sensor_uuid]
    WebsocketRails[channel].trigger('create', measurement)

    sensor = Sensor.find_by(uuid: message[:sensor_uuid])
    sensor.add_measurement! message[:timestamp], message[:value]

    send_message :post_success, 'post_success', :namespace => :measurements
  end
end

private

def sensor_channel_key(uuid)
  "sensor-#{uuid}"
end