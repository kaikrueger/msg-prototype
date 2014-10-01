require 'spec_helper'

describe Sensor do

  let(:user) { FactoryGirl.create(:user) }
  let(:device_type) { DeviceType.create(name: 'Test') }
  let(:device) { Device.create(uuid: '12345678901234567890123456789012', name: 'Device 123', device_type_id: device_type.id, user_id: user.id) }
  before {
    @sensor = device.sensors.build(uuid: '12345678901234567890123456789012', name: 'Sensor 123')
  }

  subject { @sensor }

  it { should respond_to(:uuid) }
  it { should respond_to(:name) }

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

end
