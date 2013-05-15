class DynamicStatus < ActiveRecord::Base
  attr_accessible :content, :user_id

  default_scope :order => 'dynamic_statuses.created_at DESC'

  scope :from_users_followed_by, lambda { |user| followed_by(user) }
  belongs_to :user

  has_many :comments, :as => :commentable, :dependent => :destroy

  has_many :feeds, :as => :feedable, :dependent => :destroy
  after_save do |dynamic_status|
    user = dynamic_status.user
    feed = user.feeds.build(:feedable_type => "DynamicStatus",
                            :feedable_id => id)
    feed.save
  end

  before_destroy do |dynamic_status|
    tips = Tip.find_all_by_tipable_type_and_tipable_id("DynamicStatus",dynamic_status.id)
    tips.each do |tip|
      tip.destroy
    end
  end
  private

    def self.followed_by(user)
      followed_ids = user.followed_users.map(&:id).join(",")
      where("user_id IN (#{followed_ids}) OR user_id = :user_id",
            { :user_id => user })
    end

end
