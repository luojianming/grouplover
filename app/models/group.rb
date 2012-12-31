class Group < ActiveRecord::Base
  attr_accessible :description, :name, :sex, :labels, :location,
                  :member_counts, :group_memberships_attributes,:status,:team_leader_id, :member_ids

  belongs_to :team_leader, :class_name => "User", :inverse_of => :mygroups
  has_many :group_memberships, :dependent => :destroy, 
                               :inverse_of => :group
  has_many :members, :class_name => "User", :through => :group_userships

  has_many :myinvitations, :class_name => "Invitation", 
                           :foreign_key => "initiate_group_id",
                           :dependent => :destroy, 
                           :inverse_of => :initiate_group
  has_many :group_invitationships, :dependent => :destroy, :foreign_key => "applied_group_id"
  has_many :invitations, :through => :group_invitationships, :foreign_key => "applied_group_id"

  accepts_nested_attributes_for :group_memberships,
                                :reject_if => proc { |attributes| attributes['member_id'].blank? },
                                :allow_destroy => true

  validates :name, :uniqueness => true

  attr_accessor :member_ids
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
=begin
  def member_ids
    @member_nums =  self.group_memberships.size
    @member_ids = [];
    for i in 0..@member_nums-1 
      @member_ids << self.group_memberships[i.to_s][:member_id]
    end
  end

  def member_ids=(member_ids)
    @member_nums = member_ids.size
    self.group_memberships = {}
    for i in 0..@member_nums-1
      self.group_memberships[i.to_s] = {}
      self.group_memberships[i.to_s][:member_id] = member_ids[i].to_i
    end
  end
=end

  def applied!(invitation)
    group_invitationships.create!(:invitation_id => invitation.id, :status => "pending")
  end
end
