class RegistrationsController < Devise::RegistrationsController

  protected

  def update_resource(resource, params)
    result = resource.update_attributes(params)
    resource.clean_up_passwords
    result
  end
end
