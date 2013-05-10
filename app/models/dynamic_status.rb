class DynamicStatus < ActiveRecord::Base
  attr_accessible :content, :user_id

  default_scope :order => 'dynamic_statuses.created_at DESC'

  scope :from_users_followed_by, lambda { |user| followed_by(user) }
  belongs_to :user

  has_many :comments, :as => :commentable, :dependent => :destroy

  after_save do |dynamic_status|
    user = dynamic_status.user
    feed = user.feeds.build(:model_name => "DynamicStatus",
                            :item_id => id)
    feed.save
  end
  private

    def self.followed_by(user)
      followed_ids = user.followed_users.map(&:id).join(",")
      where("user_id IN (#{followed_ids}) OR user_id = :user_id",
            { :user_id => user })
    end

end
