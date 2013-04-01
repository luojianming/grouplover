#encoding: utf-8
class GroupMembership < ActiveRecord::Base
  attr_accessible :member_id, :status, :group_id
  belongs_to :group, :counter_cache => :member_counts,
                     :inverse_of => :group_memberships
  belongs_to :member, :class_name => "User", :inverse_of => :group_memberships

  scope :unprocessed_invite, lambda{|user|where(["member_id=? AND status=?",user.id, "pending"])}
  validates :member_id, :uniqueness => { :scope => :group_id, :message => "a group cannot has the same member" }
  validates :group, :presence => true
  validates :member_id, :presence => true
  validates_associated :group

  def has_member(group, member)

  end

  def self.accept(member, group)
    gm = find_by_member_id_and_group_id(member, group)
    if gm.nil?
      return false
    else
      gm.update_attribute(:status, "accepted")
      #更新group的status
      Group.update_status(group)
    end

    return true
  end
  def self.reject(member, group)
    gm = find_by_member_id_and_group_id(member, group)
    if gm.nil?
      return false
    else
      gm.destroy
      #当group的成员少于两个人时，自动解散该组
      if Group.find(group).group_memberships.count < 1
        Group.find(group).destroy
      else
        #更新group的status
        Group.update_status(group)
      end
    end

    return true
  end
end
