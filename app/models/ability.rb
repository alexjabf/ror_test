class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new # guest user
    unless user.role.nil?
      if user.role.superadmin
        can :manage, :all
      elsif user.role.default_user
        can [:show, :edit, :update, :destroy], User, id: user.id
        can [:new, :create], UserContact
        can [:index, :show, :edit, :update, :destroy], UserContact, user_id: user.id
      elsif user.role.custom
        can [:show, :update], User, id: user.id
        can [:new, :create], UserContact
        can [:index, :show, :edit, :update], UserContact, user_id: user.id
      end
    end
  end
end
