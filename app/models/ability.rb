class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.role? "Default account"
      can :create, News
    elsif  user.role? "Manager"
      can :update, News
    end
  end
end
