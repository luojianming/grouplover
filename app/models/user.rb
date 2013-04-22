class User < ActiveRecord::Base
  extend OmniauthCallbacks
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me,
                  :descriptio, :current_password, :captcha
  has_many :authorizations, :dependent => :destroy
  has_one :profile, :dependent => :destroy
  has_one :extra_info, :dependent => :destroy
  validates :name, :presence => true
  has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy
  has_many :reverse_relationships, :foreign_key => "followed_id",
                                   :class_name => "Relationship",
                                   :dependent => :destroy

  has_many :followed_users, :through => :relationships, :source => :followed
  has_many :followers, :through => :reverse_relationships, :source => :follower

  has_many :mygroups, :class_name => "Group", 
                      :foreign_key => "team_leader_id",
                      :dependent => :destroy,
                      :inverse_of => :team_leader
  has_many :group_memberships, :foreign_key => "member_id", 
                               :dependent => :destroy,
                               :inverse_of => :member
  has_many :groups, :through => :group_memberships, :foreign_key => "member_id"

  has_many :albums, :dependent => :destroy

  has_many :photos, :through => :albums

  has_many :invitations, :through => :mygroups

  has_many :messages, :foreign_key => "sender_id", :dependent => :destroy

  has_many :sended_private_messages, :class_name => "PrivateMessage",
                                     :foreign_key => "sender_id",
                                     :dependent => :destroy

  has_many :received_private_messages, :class_name => "PrivateMessage",
                                       :foreign_key => "receiver_id",
                                       :dependent => :destroy

  has_many :sended_photo_comments, :class_name => "PhotoComment",
                                   :foreign_key => "sender_id",
                                   :dependent => :destroy

  has_many :received_photo_comments, :class_name => "PhotoComment",
                                     :foreign_key => "receiver_id",
                                     :dependent => :destroy

  has_many :tips, :dependent => :destroy
  define_index do
    indexes profile.sex, as: :user_sex
    indexes :name
    indexes profile.location, as: :user_location
    indexes profile.hometown, as: :user_hometown
    indexes profile.school, as: :user_school
  end
  sphinx_scope(:by_user_location) { |location|
    { :conditions => { :user_location => location } }
  }
  sphinx_scope(:by_hometown) { |hometown|
    { :conditions => { :user_hometown => hometown } }
  }
  sphinx_scope(:by_school) { |school|
    { :conditions => { :user_school => school } }
  }
  sphinx_scope(:by_sex) { |sex|
    { :conditions => { :user_sex => sex } }
  }
  def bind_service(response)
    provider = response["provider"]
    uid = response["uid"]
    auth = authorizations.create(:provider => provider , :uid => uid )
    auth.save
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(:followed_id => other_user.id, :status => "pending")
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  def find_friends()
    followers & followed_users
  end

  def participate_groups()
    @groups = []
    @ships =  GroupMembership.find_all_by_member_id(id)
    @ships.each do |ship|
      if ship.group.status == "active"
        @groups << ship.group
      end
    end
    @groups
  end

  def related_groups()
    participate_groups() | mygroups
  end
#如果某个用户所在的group已经申请了某invitation，则返回true,否则返回nil
  def applied?(invitation)
    groups = related_groups() 
    for group in groups
       if (invitation.group_invitationships.find_by_applied_group_id(group.id) != nil ||
         invitation.initiate_group == group)
          return true
       end
    end
    return nil
  end

  def related_active_invitations()
    result = []
    related_groups().each do |group|
      #由group发起的且已激活的invitation
      Invitation.active_invitation_initiated_by_group(group).each do |invitation|
        result << invitation
      end
      #group申请的且已激活的invitation
      GroupInvitationship.active_invitation_ship_applied_by_group(group).each do |invitation_ship|
        result << invitation_ship.invitation
      end
    end
    result
  end

  def add_visitor(visitor)
    ExtraInfo.add(extra_info, visitor)
  end

  def active_groups
    my_active_groups = []
    mygroups.each do | group|
      if group.status == "active"
        my_active_groups << group
      end
    end
    my_active_groups
  end

  def related_active_groupships()
    @my_groups = mygroups
    @result = []
    @my_groups.each do |mygroup|
      @result = @result | GroupGroupship.find_all_by_applied_group_id_and_status(mygroup.id,"active")
      @result = @result | GroupGroupship.find_all_by_target_group_id_and_status(mygroup.id,"active")
    end
    @result
  end

  def self.followed_related_groups(user)
    @followed_groups = []
    @followed_user_ids = Relationship.where("follower_id=(:user_id)", user_id: user).map(&:followed_id)
    @followed_user_ids.each do |followed_id|
      @followed_groups = @followed_groups | User.find(followed_id).related_groups
    end
    @followed_groups
  end
end
