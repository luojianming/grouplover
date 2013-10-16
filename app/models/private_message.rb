class PrivateMessage < ActiveRecord::Base
  attr_accessible :content, :receiver_id,  :original_message_id

  default_scope order: 'private_messages.created_at DESC'
  scope :related_messages, lambda{|user|where(["sender_id=? OR receiver_id=?",user.id, user.id]) }
  scope :unread_messages, lambda{|user|where(["receiver_id=? AND status=?",user.id, "unread"])}
  scope :original_messages, where( :original_message_id => -1 )
  belongs_to :sender, :class_name => "User", :dependent => :destroy
  belongs_to :receiver, :class_name => "User", :dependent => :destroy

  has_many :applied_messages, :class_name => "PrivateMessage", 
                              :foreign_key => "original_message_id",
                              :dependent => :destroy

  belongs_to :original_message, :class_name => "PrivateMessage"

end
