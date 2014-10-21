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
    measurements = sensor.get_measurements!(message[:from], message[:to])

    channel = sensor.channel_key
    WebsocketRails[channel].trigger('load', measurements)

    send_message :load_success, 'load_success', :namespace => :measurements
  end

  def post_measurement

    sensor = Sensor.find_by(uuid: message[:sensor_uuid])
    sensor.add_measurement! message[:timestamp], message[:value]

    measurement = {sensor_uuid: sensor.uuid, timestamp: message[:timestamp], value: message[:value]}

    channel = sensor.channel_key
    WebsocketRails[channel].trigger('create', measurement)

    send_message :post_success, 'post_success', :namespace => :measurements
  end
end
