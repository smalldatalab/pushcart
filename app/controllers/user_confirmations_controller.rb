class UserConfirmationsController < Devise::ConfirmationsController

  protected

  def after_confirmation_path_for(resource_name, resource)
    sign_in resource
    account_confirmation_path
  end

  def after_resending_confirmation_instructions_path_for(resource_name)
    root_path
  end
end