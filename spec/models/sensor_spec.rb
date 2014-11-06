require 'spec_helper'

describe Sensor do

  let(:user) { FactoryGirl.create(:user) }
  let(:device_type) { DeviceType.create(name: 'Test') }
  let(:sensor_type) { SensorType.create(name: 'Test') }
  let(:unit) { Unit.create(name: 'Test', symbol: 'T') }
  let(:sensor_type_unit) { SensorTypeUnit.create(sensor_type_id: sensor_type.id, unit_id: unit.id) }
  let(:device) { Device.create(uuid: '56789034123789099999124123456599', name: 'Device 1', device_type_id: device_type.id, user_id: user.id) }
  before {
    @sensor = device.sensors.build(uuid: '78901299923451231745609934568999', name: 'Sensor 1', sensor_type_unit_id: sensor_type_unit.id, min_value: 0, max_value: 1000)
    @sensor.add_measurement! 1313278101, 100
    @sensor.add_measurement! 1313278102, 200
    @sensor.add_measurement! 1313278103, 300
    @sensor.add_measurement! 1313278104, 400
    @sensor.add_measurement! 1313278105, 500
    @sensor.add_measurement! 1313278106, 600

    @other_sensor = device.sensors.build(uuid: '67856099345892990191723451234999', name: 'Sensor 2', sensor_type_unit_id: sensor_type_unit.id, min_value: 0, max_value: 1000)
    @other_sensor.add_measurement! 1313278101, 100
    @other_sensor.add_measurement! 1313278102, 200
    @other_sensor.add_measurement! 1313278103, 300
    @other_sensor.add_measurement! 1313278104, 400
    @other_sensor.add_measurement! 1313278105, 500
    @other_sensor.add_measurement! 1313278106, 600
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
      @measurements = @sensor.get_all_measurements
    }
    subject { @measurements.size }
    it { should eq 6 }
  end

  describe 'get existent measurement' do
    before {
      @value = @sensor.get_measurement 1313278102
    }
    subject { @value }
    it { should eq 200 }
  end

  describe 'get non existent measurement' do
    before {
      @value = @sensor.get_measurement 999999
    }
    subject { @value }
    it { should eq 0 }
  end

  describe 'get existent measurements' do
    before {
      @measurements = @sensor.get_measurements 1313278102, 1313278104
    }
    subject { @measurements.size }
    it { should eq 3 }
  end

  describe 'get non-existent measurements' do
    before {
      @measurements = @sensor.get_measurements 1113278102, 1113278104
    }
    subject { @measurements.size }
    it { should eq 0 }
  end

  describe 'get dirty timestamps' do
    before {
      @timestamps = @sensor.get_dirty_timestamps
    }
    subject { @timestamps.size }
    it { should eq 6 }
  end

  describe 'clear dirty timestamps' do
    before {
      @sensor.clear_dirty_timestamps!
      @timestamps = @sensor.get_dirty_timestamps
    }
    subject { @timestamps.size }
    it { should eq 0 }
  end
end
