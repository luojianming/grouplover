class Feed < ActiveRecord::Base
  attr_accessible :feedable_id, :feedable_type, :user_id
  default_scope :order => 'feeds.created_at DESC'
#  scope :from_users_followed_by, lambda { |user| followed_by(user) }
  belongs_to :user

  belongs_to :feedable, :polymorphic => true

  private

    def self.from_users_followed_by(user)
#      followed_ids = user.followed_users.map(&:id).join(",")
      followed_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
      where("user_id IN (#{followed_ids}) OR user_id = :user_id",
             :user_id => user.id )
    end
end
