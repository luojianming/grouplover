#encoding: utf-8
class AuthenticationsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]

    authentication = Authentication.find_by_provider_and_uid(auth['provider'], auth['uid'])

    if authentication
      flash[:notice] = "登录成功."
      sign_in_and_redirect(:user, authentication.user)
    else
      user = User.new
      user.apply_omniauth(auth)
      if user.save(:validate => false)
        flash[:notice] = "Account created and signed in successfully."
        sign_in_and_redirect(:user, user)
      else
        flash[:error] = "创建账户失败，请重试."
        redirect_to root_url
      end
    end
  end
end
