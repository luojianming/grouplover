class Comment < ActiveRecord::Base
  attr_accessible :commentable_id, :commentable_type, :content, :receiver_id, :sender_id
  belongs_to :commentable, :polymorphic => true
  belongs_to :sender, :class_name => "User"
  belongs_to :receiver, :class_name => "User"
end
