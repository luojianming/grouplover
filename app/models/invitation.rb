#encoding: utf-8
class Invitation < ActiveRecord::Base
  attr_accessible :description, :initiate_group_id, :location, :lover_style, :status, :style, :time, :activity, :image_url
  default_scope order: 'invitations.created_at DESC'
  belongs_to :initiate_group, :class_name => "Group", :inverse_of => :myinvitations
  has_many :group_invitationships, :dependent => :destroy
  has_many :applied_group, :class_name => "Group", :through => :group_invitationships

  has_one :conversation, :as => :conversationer

  validates :initiate_group_id, :presence => true
  validates :style, :presence => true
  validates :location, :presence => true
  validates :time, :presence => true

  define_index do
    indexes location
  end

  def self.initiated_by_users_followed_by(user)
    followed_user_ids = Relationship.where("follower_id=(:user_id)", user_id: user).map(&:followed_id)

    followed_user_mygroup_ids = GroupMembership.where("member_id IN (:followed_user_ids)", followed_user_ids: followed_user_ids).map(&:group_id)
    where("initiate_group_id IN (:followed_user_mygroup_ids)", followed_user_mygroup_ids: followed_user_mygroup_ids)
  end

  def self.initiated_by_user(user)
    mygroup_ids = user.mygroups.map(&:id)
    where("initiate_group_id IN (:mygroup_ids)", mygroup_ids: mygroup_ids)
  end
end
