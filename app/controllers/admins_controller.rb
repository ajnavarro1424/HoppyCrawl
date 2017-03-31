class AdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize
  def index
    @users = User.all
  end

  def update
     user = User.find(params[:id])
     user.roles.destroy_all # user only has one role
     user.add_role(params[:role])
     redirect_to '/admins/index'
   end

   private
   def authorize
    if !current_user.has_role? :admin
      render text:"No access for you!"
    end
  end
end
