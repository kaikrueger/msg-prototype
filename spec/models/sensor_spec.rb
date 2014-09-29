require 'spec_helper'

describe Sensor do
  before do
    @sensor = Sensor.new(uuid: "12345678901234567890123456789012", name: "Sensor123")
  end

  subject { @sensor }

  it { should respond_to(:uuid) }
  it { should respond_to(:name) }

  it { should be_valid }

  describe "when uuid is not present" do
    before { @sensor.uuid = " " }
    it { should_not be_valid }
  end

  describe "when name is not present" do
    before { @sensor.name = " " }
    it { should_not be_valid }
  end

end
