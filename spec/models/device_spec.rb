require 'spec_helper'

describe Device do

  let(:user) { FactoryGirl.create(:user) }
  let(:aggregate_type) { DeviceType.find_by(name: 'device.type.aggregate') }
  let(:flukso_type) { DeviceType.find_by(name: 'device.type.flukso2') }
  let(:raspberry_pi_type) { DeviceType.find_by(name: 'device.type.raspberry_pi') }

  let(:flukso) { Device.create(uuid: '12345678901234567890123456789012', name: 'Device 1', device_type_id: flukso_type.id, user: user, user_id: user.id) }
  let(:raspberry_pi) { Device.create(uuid: '12345678990456789012012312345678', name: 'Device 2', device_type_id: raspberry_pi_type.id, user: user, user_id: user.id) }
  let(:aggregate_device) { Device.create(uuid: '78989012101234567123456234567890', name: 'Aggregate Device', device_type_id: aggregate_type.id, user: user, user_id: user.id) }

  let(:sensor_type) { SensorType.find_by(name: 'sensor.type.energy_consumption') }
  let(:watt) { Unit.find_by(symbol: 'W') }
  let(:sensor_type_unit) { SensorTypeUnit.find_by(sensor_type_id: sensor_type.id, unit_id: watt.id) }

  before {
    clear_all_redis_data

    @first_sensor = Sensor.create(device_id: flukso.id, device: flukso, uuid: '99665678901234599912345678901234', name: 'Sensor 1', sensor_type_unit_id: sensor_type_unit.id, min_value: 0, max_value: 1000)
    @first_sensor.add_measurement! 1413278101, 100
    @first_sensor.add_measurement! 1413278102, 200
    @first_sensor.add_measurement! 1413278103, 300
    @first_sensor.add_measurement! 1413278104, 400
    @first_sensor.add_measurement! 1413278105, 500
    @first_sensor.add_measurement! 1413278106, 600

    @second_sensor = Sensor.create(device_id: raspberry_pi.id, device: raspberry_pi, uuid: '12345678901234512345678909999966', name: 'Sensor 2', sensor_type_unit_id: sensor_type_unit.id, min_value: 0, max_value: 1000)
    @second_sensor.add_measurement! 1413278101, 100
    @second_sensor.add_measurement! 1413278102, 200
    @second_sensor.add_measurement! 1413278103, 300
    @second_sensor.add_measurement! 1413278104, 400
    @second_sensor.add_measurement! 1413278105, 500
    @second_sensor.add_measurement! 1413278106, 600

    @aggregate_sensor = Sensor.create(device_id: aggregate_device.id, device: aggregate_device, uuid: '49123911234597890902345678996656', name: 'Sensor 3', sensor_type_unit_id: sensor_type_unit.id, min_value: 0, max_value: 1000)
    Device.aggregate
  }

  subject { flukso }

  it { should respond_to(:uuid) }
  it { should respond_to(:name) }

  it { should respond_to(:device_type_id) }
  it { should respond_to(:device_type) }
  its(:device_type) { should eq flukso_type }

  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should respond_to(:sensors) }

  it { should be_valid }

  describe 'when uuid is not present' do
    before { flukso.uuid = ' ' }
    it { should_not be_valid }
  end

  describe 'when name is not present' do
    before { flukso.name = ' ' }
    it { should_not be_valid }
  end

  describe 'get aggregate sensors' do
    before {
      @aggregate_sensors = Device.get_aggregate_sensors
    }

    subject { @aggregate_sensors }
    its(:length) { should eq (1 + 2 + 2) }
    it { should include(@aggregate_sensor) }
  end

  describe 'get aggregated sensors' do
    before {
      @aggregated_sensors = Device.get_aggregated_sensors @aggregate_sensor
    }

    subject { @aggregated_sensors }
    its(:length) { should eq 2 }
    it { should include(@first_sensor) }
    it { should include(@second_sensor) }
  end

  describe 'get aggregated measurement - first timestamp' do

    subject { @aggregate_sensor.get_measurement 1413278101 }
    it { should eq 200 }
  end

  describe 'get aggregated measurement - last timestamp' do

    subject { @aggregate_sensor.get_measurement 1413278106 }
    it { should eq 1200 }
  end
end
