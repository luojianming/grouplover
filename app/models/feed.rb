class Feed < ActiveRecord::Base
  attr_accessible :item_id, :model_name, :user_id
  default_scope :order => 'feeds.created_at DESC'
  scope :from_users_followed_by, lambda { |user| followed_by(user) }
  belongs_to :user

  private

    def self.followed_by(user)
      followed_ids = user.followed_users.map(&:id).join(",")
      where("user_id IN (#{followed_ids}) OR user_id = :user_id",
            { :user_id => user })
    end
end
