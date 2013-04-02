#encoding: utf-8
class User
  module OmniauthCallbacks
    ["weibo","douban","xiaonei"].each do |provider|
      define_method "find_or_create_for_#{provider}" do |response|
        uid = response["uid"]
        data = response["info"]
        extra = response["extra"]
        Rails.logger.warn(extra)
#       if user = User.joins(:authorizations).where("authorizations.provider" => provider , "authorizations.uid" => uid).first
#         user
        if user = Authorization.find_by_provider_and_uid(provider,uid).try(:user)
          user
        elsif user = User.find_by_email(data["email"])
          user.bind_service(response)
          user
        else
          user = User.new_from_provider_data(provider, uid, data)

          if user.save(:validate => false)
            debugger
            user.authorizations << Authorization.new(:provider => provider, :uid => uid, :head_url => extra["raw_info"]["headurl"] )
            profile = user.build_profile()
            profile.status = "active"
            profile.save(:validate => false)
            extra_info = user.build_extra_info()
            extra_info.save(:validate => false)
            return user
          else
            Rails.logger.warn("User.create_from_hash 失败，#{user.errors.inspect}")
            return nil
          end
        end
      end
    end

    def new_from_provider_data(provider, uid, data)
      User.new do |user|
        user.email = data["email"]
        user.email = "weibo+#{uid}@itripl.com" if provider == "weibo"
        user.email = "douban+#{uid}@itripl.com" if provider == "douban"
        user.email = "xiaonei+#{uid}@itripl.com" if provider == "xiaonei"
        
         user.name = data["name"]
#        user.login = data["name"] if provider == "google"
#        user.login.gsub!(/[^\w]/, "_")
=begin
        if User.where(:login => user.login).count > 0 || user.login.blank?
          user.login = "u#{Time.now.to_i}" # TODO: possibly duplicated user login here. What should we do?
        end
=end
         user.password = Devise.friendly_token[0, 20]
    #     user.location = data["location"]
 #       user.tagline = data["description"]
      end
    end
  end
end
