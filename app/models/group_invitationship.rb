class GroupInvitationship < ActiveRecord::Base
  attr_accessible :applied_group_id, :status, :invitation_id
  belongs_to :applied_group, :class_name => "Group"
  belongs_to :invitation
end
