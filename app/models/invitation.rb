#encoding: utf-8
class Invitation < ActiveRecord::Base
  attr_accessible :description, :initiate_group_id, :location, :lover_style, :status, :style, :time, :activity, :image_url
  default_scope order: 'invitations.created_at DESC'
  scope :active_invitation_initiated_by_group, 
        lambda{ |group|where(["initiate_group_id=? AND status=?", group.id, "active"]) }
  belongs_to :initiate_group, :class_name => "Group", :inverse_of => :myinvitations
  has_many :group_invitationships, :dependent => :destroy
  has_many :applied_groups, :class_name => "Group", :through => :group_invitationships

  has_one :conversation, :as => :conversationer

  validates :initiate_group_id, :presence => true
  validates :style, :presence => true
  validates :location, :presence => true
  validates :time, :presence => true

  define_index do
    indexes location
    indexes time
    has initiate_group.member_counts, as: :group_member_counts
    indexes initiate_group.location, as: :city
  end

  sphinx_scope(:by_location) { |location|
    { :conditions => { :location => location } }
  }

  sphinx_scope(:by_time) { |time|
    { :conditions => { :time => time } }
  }

  sphinx_scope(:with_member_counts) { |group_member_counts|
    { :with => { :group_member_counts => group_member_counts } }
  }

  sphinx_scope(:by_city) { |city|
    { :conditions => { :city => city } }
  }

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
