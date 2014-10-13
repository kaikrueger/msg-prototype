require 'spec_helper'

describe SensorTypeUnit do

  let(:sensor_type) { SensorType.create(name: 'Test') }
  let(:unit) { Unit.create(name: 'Test', symbol: 'T') }
  before do
    @sensor_type_unit = SensorTypeUnit.new(sensor_type_id: sensor_type.id, unit_id: unit.id)
  end

  subject { @sensor_type_unit }

  it { should respond_to(:unit_id) }
  it { should respond_to(:sensor_type_id) }
  it { should respond_to(:name) }

  it { should be_valid }
end
