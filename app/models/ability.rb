class Ability
  include CanCan::Ability

  def initialize(user)
    if user.nil?
      # if no user logged in, use a dummy user, see later
      user = User.new
    end
    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :user
      can :manage, Crawl, user_id: user.id
    end
  end
end
