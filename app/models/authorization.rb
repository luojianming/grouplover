class Authorization < ActiveRecord::Base
  attr_accessible :provider, :uid, :user_id, :head_url
  belongs_to :user
  validates :provider, :uniqueness => { :scope => :user_id }
  validates :uid, :uniqueness => { :scope => :provider }
end
