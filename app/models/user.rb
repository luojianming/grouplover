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
                  :location, :school, :sex, :hometown, :hobby, :head_url, :lover_style,
                  :style, :status, :descriptio, :current_password
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

  has_many :messages, :foreign_key => "sender_id"

  def bind_service(response)
    provider = response["provider"]
    uid = response["uid"]
    authorizations.create(:provider => provider , :uid => uid )
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(:followed_id => other_user.id)
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
  
end
