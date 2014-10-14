require 'spec_helper'

describe Sensor do

  let(:user) { FactoryGirl.create(:user) }
  let(:device_type) { DeviceType.create(name: 'Test') }
  let(:sensor_type) { SensorType.create(name: 'Test') }
  let(:unit) { Unit.create(name: 'Test', symbol: 'T') }
  let(:sensor_type_unit) { SensorTypeUnit.create(sensor_type_id: sensor_type.id, unit_id: unit.id) }
  let(:device) { Device.create(uuid: '12345678901234567890123456789999', name: 'Device 123', device_type_id: device_type.id, user_id: user.id) }
  before {
    @sensor = device.sensors.build(uuid: '12345678901234567890123456789999', name: 'Sensor 123', sensor_type_unit_id: sensor_type_unit.id, min_value: 0, max_value: 1000)
  }

  subject { @sensor }

  it { should respond_to(:uuid) }
  it { should respond_to(:name) }
  it { should respond_to(:min_value) }
  it { should respond_to(:max_value) }

  it { should respond_to(:sensor_type_unit_id) }
  it { should respond_to(:sensor_type_unit) }
  its(:sensor_type_unit) { should eq sensor_type_unit }

  it { should respond_to(:device_id) }
  it { should respond_to(:device) }
  its(:device) { should eq device }

  it { should be_valid }

  describe 'when uuid is not present' do
    before { @sensor.uuid = ' ' }
    it { should_not be_valid }
  end

  describe 'when name is not present' do
    before { @sensor.name = ' ' }
    it { should_not be_valid }
  end

  describe 'get all measurements' do

    before {
      @sensor.add_measurement! 1413278100, 100
      @sensor.add_measurement! 1413278200, 200
      @sensor.add_measurement! 1413278300, 300
      @measurements = @sensor.get_all_measurements!
    }

    subject { @measurements.size }
    it { should eq 3 }
  end
end
