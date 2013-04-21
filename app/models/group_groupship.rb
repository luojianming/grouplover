class GroupGroupship < ActiveRecord::Base
  attr_accessible :applied_group_id, :description, :location, :target_group_id, 
                  :time, :status, :activity
  belongs_to :applied_group, :class_name => "Group"
  belongs_to :target_group, :class_name => "Group"

  has_one :conversation, :as => :conversationer, :dependent => :destroy

  validates :applied_group_id, :presence => true
  validates :target_group_id, :presence => true
end
