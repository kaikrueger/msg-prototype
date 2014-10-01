require 'spec_helper'

describe DeviceType do

  before do
    @device_type = DeviceType.new(name: 'Test')
  end

  subject { @device_type }

  it { should respond_to(:name) }

  it { should be_valid }

  describe 'when name is not present' do
    before { @device_type.name = ' ' }
    it { should_not be_valid }
  end

end
