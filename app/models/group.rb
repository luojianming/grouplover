#encoding: utf-8
class Group < ActiveRecord::Base
  attr_accessible :description, :name, :sex, :location,
                  :member_counts, :group_memberships_attributes,
                  :status, :member_ids, :image, :remote_image_url

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

  has_many :group_groupships, :dependent => :destroy, :foreign_key => "applied_group_id"
  has_many :target_groups, :through => :group_groupships, :foreign_key => "applied_group_id"

  has_many :reverse_group_groupships, :foreign_key => "target_group_id",
                                      :class_name => "GroupGroupship",
                                      :dependent => :destroy
  has_many :applied_groups, :through => :reverse_group_groupships, :foreign_key => "target_group_id"

  has_one :conversation, :as => :conversationer, :dependent => :destroy

  has_many :comments, :as => :commentable,:dependent => :destroy
  has_many :feeds, :as => :feedable, :dependent => :destroy
  accepts_nested_attributes_for :group_memberships,
                                :reject_if => proc { |attributes| attributes['member_id'].blank? },
                                :allow_destroy => true

  validates :name, :presence => true, :length => { :maximum => 8,
                                                     :too_long => "名字最多不能超过8个字哦"}
  validates :sex,  :presence => true
#  validates :member_counts, :numericality => { :greater_than => 0, :less_than => 4 } 
  validates :location, :presence => true
 # validate :labels_number_cannot_greater_than_three 

  mount_uploader :image, ImageUploader

  attr_accessor :member_ids

  define_index do
    indexes :name
    indexes location
    has member_counts
    indexes sex
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
  sphinx_scope(:by_sex) { |sex|
    { :conditions => { :sex => sex } }
  }
=begin
  def labels_number_cannot_greater_than_three
    if labels.split(",").length >= 3
      errors.add(:labels, "标签个数最多不能超过两个")
    end
  end
=end
#当且仅当所有的group_membership的status为accepted时才能变成active
  def self.update_status(group)
      group_status = "active"
      @group = Group.find(group)
      @group.group_memberships.each do |ship|
        if ship.status != "accepted"
          group_status = "pending"
          break
        end
      end
      @group.update_attributes(:status => group_status)
      if group_status == "active"
        @group.create_conversation()
        @group.create_feed
      end
  end

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

  def self.be_active?(group)
    if(GroupInvitationship.find_by_applied_group_id(group.id) != nil || 
       GroupGroupship.find_by_applied_group_id(group.id) != nil ||
      GroupGroupship.find_by_target_group_id(group.id) != nil ||
      Invitation.find_by_initiate_group_id(group.id) != nil)
      return true
    else
      return false
    end
  end


  def actived_invitations
    @actived_invitations = Invitation.find_all_by_initiate_group_id_and_status(id,"active")
    @actived_invitationships = []
    @actived_invitations.each do |active_invitation|
      @actived_invitationships << GroupInvitationship.find_by_invitation_id(active_invitation.id)
    end
    @actived_invitationships = @actived_invitationships | GroupInvitationship.find_all_by_applied_group_id_and_status(id, "active")
    @actived_invitationships = @actived_invitationships | GroupGroupship.find_all_by_applied_group_id_and_status(id,"active")
    @actived_invitationships = @actived_invitationships | GroupGroupship.find_all_by_target_group_id_and_status(id,"active")
  end
#收到的邀请
  def invite_posts
    @group_groupships = GroupGroupship.find_all_by_target_group_id_and_status(id, "pending")
  end

  #发布的活动
  def sended_public_posts
    @group_invitationships = GroupInvitationship.find_all_by_applied_group_id_and_status(id, "pending")
  end

  #发出的邀请
  def sended_private_posts
    @group_groupships = GroupGroupship.find_all_by_applied_group_id_and_status(id,"pending")
  end

  def received_invitations
    GroupGroupship.find_all_by_target_group_id_and_status(id, "pending")
  end

  def the_group_should_be_exist
    begin
      @group = Group.find(params[:id])
    rescue
      flash[:error] = "您访问的页面不存在"
      redirect_to user_path(current_user)
      return false
    end
  end

  def create_feed
    user = team_leader
    feed = user.feeds.build(:feedable_type => "Group",
                            :feedable_id => id)
    feed.save
    members.each do |member|
      feed = member.feeds.build(:feedable_type => "Group",
                                :feedable_id => id)
      feed.save
    end
  end

  before_destroy do |group|
    tips = Tip.find_all_by_tipable_type_and_tipable_id("Group",group.id)
    tips.each do |tip|
      tip.destroy
    end
  end

end
