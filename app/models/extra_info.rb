class ExtraInfo < ActiveRecord::Base
  attr_accessible  :vistors
  validates :user_id, :presence => true
  belongs_to :user

  def extra_info(user)
    ExtraInfo extra_info = @user.extra_info ||= ExtraInfo.new
  end
end
