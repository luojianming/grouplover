class Users::RegistrationsController < Devise::RegistrationsController
  def new
   render :layout => "sign_in"

  end

  def edit
  end
  def create
    build_resource

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        resource.create_profile()
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
     # respond_with({}, :location => after_sign_up_path_fails_for(resource))
     # redirect_to new_user_registration_path
     #  render :action => 'new'
     #  respond_with resource, :location => after_sign_up_path_fails_for(resource)
        respond_with resource       
    end
  end
private
=begin
  def after_sign_up_path_fails_for(resource)
    new_user_registration_path 
  end
=end
  def after_sign_up_path_for(resource)
    user_path(current_user)
  end

  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end
end
