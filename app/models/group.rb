class Group < ActiveRecord::Base
  attr_accessible :description, :name, :sex, :labels, :location,
                  :member_counts, :group_memberships_attributes, :status, :team_leader_id

  belongs_to :team_leader, :class_name => "User"
  has_many :group_memberships, :dependent => :destroy
  has_many :members, :class_name => "User", :through => :group_userships

  accepts_nested_attributes_for :group_memberships,
                                :reject_if => proc { |attributes| attributes['member_id'].blank? }

#当且仅当所有的group_membership的status为accepted时才能变成active
  def self.update_status(group)
      group_status = "active"
      Group.find(group).group_memberships.each do |ship|
        if ship.status != "accepted"
          group_status = "pending"
          break
        end
      end
      Group.find(group).update_attributes(:status => group_status)
  end
end
