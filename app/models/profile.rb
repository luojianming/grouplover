class Profile < ActiveRecord::Base
  attr_accessible :animation, :birthday, :books, :email, :games, :hometown, :movie, :msn, :music, :musical_instruments, :qq, :school, :sex, :sports, :telephone
  validates :user_id, :presence => true
  belongs_to :user
  validates :books, :presence => true
end
