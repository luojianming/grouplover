class Message < ActiveRecord::Base
  attr_accessible :content, :conversation_id, :sender_id
  belongs_to :conversation
  belongs_to :sender, :class_name => "User"
end
