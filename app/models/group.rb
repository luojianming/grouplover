class Group < ActiveRecord::Base
  attr_accessible :description, :name, :sex, :labels, :location,
                  :member_counts, :group_memberships_attributes,:status

  belongs_to :team_leader, :class_name => "User", :inverse_of => :mygroups
  has_many :group_memberships, :dependent => :destroy, 
                               :inverse_of => :group
  has_many :members, :class_name => "User", :through => :group_userships

  has_many :myinvitations, :class_name => "Invitation", 
                           :dependent => :destroy, 
                           :foreign_key => "initiate_group_id",
                           :inverse_of => :initiate_group
  has_many :group_invitationships, :dependent => :destroy, :foreign_key => "applied_group_id"
  has_many :invitations, :through => :group_invitationships, :foreign_key => "applied_group_id"

  accepts_nested_attributes_for :group_memberships,
                                :reject_if => proc { |attributes| attributes['member_id'].blank? },
                                :allow_destroy => true

  validates :name, :uniqueness => true


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
