class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new # guest user
    unless user.role.nil?
      if user.role.superadmin
        can :manage, :all
      elsif user.role.administrator
      elsif user.role.agent
      elsif user.role.driver
        can :manage, :all
      elsif user.role.default_user
        can :manage, :all
      elsif user.role.custom
      end
    end
    gloabal_abilities
  end

  def gloabal_abilities
    can :manage, :all
  end

end
