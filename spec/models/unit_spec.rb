require 'spec_helper'

describe Unit do

  before do
    @unit = Unit.new(name: 'Test', symbol: 'T')
  end

  subject { @unit }

  it { should respond_to(:name) }
  it { should respond_to(:sensor_type_units) }
  it { should respond_to(:symbol) }

  it { should be_valid }

  describe 'when name is not present' do
    before { @unit.name = ' ' }
    it { should_not be_valid }
  end

  describe 'when symbol is not present' do
    before { @unit.symbol = ' ' }
    it { should_not be_valid }
  end

end
