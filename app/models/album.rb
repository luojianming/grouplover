class Album < ActiveRecord::Base
  attr_accessible :description, :name, :user_id
  belongs_to :user
  has_many :photos, :dependent => :destroy
  
  validates :name, :presence => true
  validates :user_id, :presence => true
  validates :description, :length => { :maximum => 200 }
end
