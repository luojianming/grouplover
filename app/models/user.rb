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
                  :style, :status
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
  
end
