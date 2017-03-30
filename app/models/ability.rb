class Ability
  include CanCan::Ability

  def initialize(user)
    if user.nil?
      # if no user logged in, use a dummy user, see later
      user = User.new
    end
    if user.has_role? :admin
      can :manage, :all
    # elsif user.has_role? :auth_user
    #   can :manage, Crawl
    # elsif user.has_role? :unauth_user
    #   can :read, Crawl, user_id: user.id
    end
  end
end
