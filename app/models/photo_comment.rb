class PhotoComment < ActiveRecord::Base
  attr_accessible :content, :photo_id, :receiver_id, :sender_id, :status, :original_comment_id
  belongs_to :photo
  belongs_to :sender, :class_name => "User"
  belongs_to :receiver, :class_name => "User"

  scope :unread_reply_comments, lambda{ |user|where(["receiver_id=? AND status=?",user.id, "unread"]) }

  has_many :replied_comments, :class_name => "PhotoComment",
           :foreign_key => "original_comment_id"

  belongs_to :original_comment, :class_name => "PhotoComment"

#  default_scope order: 'photo_comments.created_at DESC'
end
