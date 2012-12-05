class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  extend OmniauthCallbacks

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
<<<<<<< HEAD
  has_many :authentifications, :dependent => :delete_all 


  def apply_omniauth(auth)
  end
=======
  
  has_many :authorizations
>>>>>>> weibo-auth
end
