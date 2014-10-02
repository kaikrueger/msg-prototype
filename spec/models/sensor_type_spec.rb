require 'spec_helper'

describe SensorType do

  before do
    @sensor_type = SensorType.new(name: 'Test')
  end

  subject { @sensor_type }

  it { should respond_to(:name) }
  it { should respond_to(:sensors) }

  it { should be_valid }

  describe 'when name is not present' do
    before { @sensor_type.name = ' ' }
    it { should_not be_valid }
  end

end
