class UserRegistrationsController < Devise::RegistrationsController
  before_action :update_sanitized_params

  def create
    build_resource(sign_up_params)

    if resource.save
      if resource.active_for_authentication?
        associate_with_coach(resource, params[:user][:coach_id]) if params[:user][:coach_id]
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        render json: { success: true }
      else
        associate_with_coach(resource, params[:user][:coach_id]) if params[:user][:coach_id]
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_data_after_sign_in!
        render json: { success: true }
      end
    else
      clean_up_passwords resource
      render json: { success: false, errors: resource.errors.full_messages.join(", ") }
    end
  end

  protected

  def after_inactive_sign_up_path_for(resource)
    thank_you_for_registering_path
  end

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :household_size)}
  end

  def associate_with_coach(user, coach_id)
    o = user.memberships.create(coach_id: coach_id)
    Rails.logger.info o.errors unless o.errors.blank?
  end

end