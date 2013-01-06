class Profile < ActiveRecord::Base
  attr_accessible :sex, :location, :hometown, :status, :avatar, :hobby, :style, :lover_style, :description,
                  :animation, :birthday, :books, :games, :movie, :msn, :music, 
                  :musical_instruments, :qq, :school, :sports, :telephone, :profession, :email
  validates :user_id, :presence => true
  belongs_to :user
  mount_uploader :avatar, ImageUploader
end
