class GroupMembership < ActiveRecord::Base
  attr_accessible :member_id, :status
  belongs_to :group
  belongs_to :member, :class_name => "User"


  def has_member(group, member)
    
  end

  def self.accept(member, group)
    gm = find_by_member_id_and_group_id(member, group)
    if gm.nil?
      return false
    else
      gm.update_attributes(:status => "accepted")
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
    end

    return true
  end
end
