require 'spec_helper'

describe DeviceType do

  let(:type) { DeviceType.find_by(name: 'device.type.flukso2') }

  subject { type }

  it { should respond_to(:name) }
  it { should respond_to(:devices) }

  it { should be_valid }

  describe 'when name is not present' do
    before { type.name = ' ' }
    it { should_not be_valid }
  end

end
