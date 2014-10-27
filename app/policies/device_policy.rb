class DevicePolicy
  attr_reader :user, :device

  #FIXME: improve this class

  def initialize(user, device)
    @user = user
    @device = device
  end

  def update?
    device.user.admin
  end

  def destroy?
    device.user.admin
  end
end