class Profile < ActiveRecord::Base
  attr_accessible :sex, :location, :hometown, :status, :avatar, :hobby, :style, :lover_style, :description,
                  :animation, :birthday, :books, :games, :movie, :msn, :music, 
                  :musical_instruments, :qq, :school, :sports, :telephone, :profession, :email, :remote_avatar_url
  validates :user_id, :presence => true
  validates :sex, :presence => true
  validates :hometown, :presence => true
  validates :location, :presence => true
  validates :hobby, :presence => true
  validates :style, :presence => true, :length => { :maximum => 20 }
  validates :lover_style, :length => { :maximum => 20 }
  belongs_to :user
  mount_uploader :avatar, ImageUploader
end
