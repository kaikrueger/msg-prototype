class SensorPolicy
  attr_reader :user, :sensor

  #FIXME: improve this class

  def initialize(user, sensor)
    @user = user
    @sensor = sensor
  end

  def update?
    sensor.device.user.admin
  end

  def destroy?
    sensor.device.user.admin
  end
end