class Profile < ActiveRecord::Base
  attr_accessible :animation, :birthday, :books, :games, :movie, :msn, :music, :musical_instruments, :qq, :school, :sports, :telephone, :profession, :email
  validates :user_id, :presence => true
  belongs_to :user
end
