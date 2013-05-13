class GroupGroupship < ActiveRecord::Base
  attr_accessible :applied_group_id, :description, :location, :target_group_id, 
                  :time, :status, :activity
  belongs_to :applied_group, :class_name => "Group"
  belongs_to :target_group, :class_name => "Group"

  has_one :conversation, :as => :conversationer, :dependent => :destroy

  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :feeds, :as => :feedable, :dependent => :destroy

  validates :applied_group_id, :presence => true
  validates :target_group_id, :presence => true

  def accept
    update_attribute("status","active")
    create_feed
  end

  def create_feed
    applied_group.team_leader.feeds.create(:feedable_type => "GroupGroupship",
                                           :feedable_id => id)
    target_group.team_leader.feeds.create(:feedable_type => "GroupGroupship",
                                           :feedable_id => id)
    (applied_group.members | target_group.members).each do |member|
      member.feeds.create(:feedable_type => "GroupGroupship",
                          :feedable_id => id)
    end
  end
end
