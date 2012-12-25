class Invitation < ActiveRecord::Base
  attr_accessible :description, :initiate_group_id, :location, :lover_style, :status, :style, :time
  belongs_to :initiate_group, :class_name => "Group", :inverse_of => :invitations
  has_many :group_invitationships, :dependent => :destroy
  has_many :applied_group, :class_name => "Group", :through => :group_invitationships
end 
