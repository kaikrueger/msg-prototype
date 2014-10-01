require 'spec_helper'

describe Device do

  let(:user) { FactoryGirl.create(:user) }
  let(:device_type) { DeviceType.create(name: 'Test') }
  before {
    @device = user.devices.build(uuid: '12345678901234567890123456789012', name: 'Device 123', device_type_id: device_type.id)
  }

  subject { @device }

  it { should respond_to(:uuid) }
  it { should respond_to(:name) }

  it { should respond_to(:device_type_id) }
  it { should respond_to(:device_type) }
  its(:device_type) { should eq device_type }

  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should respond_to(:sensors) }

  it { should be_valid }

  describe 'when uuid is not present' do
    before { @device.uuid = ' ' }
    it { should_not be_valid }
  end

  describe 'when name is not present' do
    before { @device.name = ' ' }
    it { should_not be_valid }
  end
end
