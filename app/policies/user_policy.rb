class UserPolicy
  attr_reader :user

  #FIXME: improve this class

  def initialize(user)
    @user = user
  end

  def update?
    user.admin
  end

  def destroy?
    user.admin
  end
end