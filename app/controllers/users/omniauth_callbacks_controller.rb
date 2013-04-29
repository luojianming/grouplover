# coding: utf-8
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def self.provides_callback_for(*providers)
     providers.each do |provider|
      class_eval %Q{
        def #{provider}
          if not current_user.blank?
            current_user.bind_service(env["omniauth.auth"])#Add an auth to existing
            redirect_to edit_user_registration_path, :notice => "成功绑定了 #{provider} 帐号。"
          else
            @user = User.find_or_create_for_#{provider}(env["omniauth.auth"])

            if @user.persisted?
              r = User.find(16).relationships.build(:followed_id => resource.id)
              r.save
              r = User.find(53).relationships.build(:followed_id => resource.id)
              r.save
              r = User.find(57).relationships.build(:followed_id => resource.id)
              r.save
              r = User.find(49).relationships.build(:followed_id => resource.id)
              r.save
              flash[:notice] = "用 #{provider.to_s.titleize} 帐号登录成功."
              sign_in @user, :event => :authentication
              redirect_to user_path(@user)
            else
              redirect_to new_user_registration_url
            end
          end
        end
      }
    end
  end

  provides_callback_for :weibo, :douban, :xiaonei

  # This is solution for existing accout want bind Google login but current_user is always nil
  # https://github.com/intridea/omniauth/issues/185
  def handle_unverified_request
    true
  end
end
