class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_dob

  protected

  def check_dob
  # if the current_user is present and if dob is blank
    if current_user.present? && current_user.dob.blank?
  # then redirect to user edit
      redirect_to '/users/edit' unless request.fullpath == '/users/edit' || request.fullpath == '/users'
  # with a message that asks for dob
      flash[:alert] = "Please fill in valid date of birth."
    # else
    #  redirect_to "/"
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:dob])

    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:dob])
    # devise_parameter_sanitizer.permit(:account_update, keys: [:current_password])
  end
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, notice: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end



end
