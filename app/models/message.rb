class Message < ActiveRecord::Base
  attr_accessible :content, :sender_id
  belongs_to :conversation
  belongs_to :sender, :class_name => "User"
end
