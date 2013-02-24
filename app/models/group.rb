#encoding: utf-8
class Group < ActiveRecord::Base
  attr_accessible :description, :name, :sex, :labels, :location,
                  :member_counts, :group_memberships_attributes,
                  :status, :member_ids, :image

  belongs_to :team_leader, :class_name => "User", :inverse_of => :mygroups
  has_many :group_memberships, :dependent => :destroy, 
                               :inverse_of => :group
  has_many :members, :class_name => "User", :through => :group_memberships

  has_many :myinvitations, :class_name => "Invitation", 
                           :foreign_key => "initiate_group_id",
                           :dependent => :destroy, 
                           :inverse_of => :initiate_group
  has_many :group_invitationships, :dependent => :destroy, :foreign_key => "applied_group_id"
  has_many :invitations, :through => :group_invitationships, :foreign_key => "applied_group_id"

  has_one :conversation, :as => :conversationer

  accepts_nested_attributes_for :group_memberships,
                                :reject_if => proc { |attributes| attributes['member_id'].blank? },
                                :allow_destroy => true

  validates :name, :uniqueness => true, :length => { :maximum => 8,
                                                     :too_long => "名字最多不能超过8个字哦"}
  validates :sex, :presence => true
  validates :labels, :presence => true, :length => { :maximum => 20,
                                                    :too_long => "标签总长度不能超过20个字哦"}
  validates :location, :presence => true
 # validates :member_counts, :numericality => { :less_than => 3 }
  validate :labels_number_cannot_greater_than_three 

  mount_uploader :image, ImageUploader

  attr_accessor :member_ids

  define_index do
    indexes :name
    indexes location
    has member_counts
  end
  sphinx_scope(:by_group_location) { |location|
    { :conditions => { :location => location } }
  }
  sphinx_scope(:with_member_counts) { |member_counts|
    { :with => { :member_counts => member_counts } }
  }
  sphinx_scope(:by_name) { |name|
    { :conditions => { :name => name } }
  }
  def labels_number_cannot_greater_than_three
    if labels.split(",").length >= 3
      errors.add(:labels, "标签个数最多不能超过两个")
    end
  end
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
      if group_status == "active"
        group.create_conversation()
      end
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

  def applied!(invitation, description)
    group_invitationships.create!(:invitation_id => invitation.id, :status => "pending", :description => description)
  end
#如果group能申请该invitation返回true，否则返回false
  def can_applied?(invitation)
    if team_leader.applied?(invitation)
      return false
    end
    members.each do |member|
      if member.applied?(invitation)
        return false
      end
    end
    return true
  end
end
