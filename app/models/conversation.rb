class Conversation < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :conversationer, :polymorphic => true
  has_many :messages, :dependent => :destroy
end
