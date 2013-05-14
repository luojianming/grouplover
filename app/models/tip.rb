class Tip < ActiveRecord::Base
  attr_accessible :content, :user_id,:tip_type, :tipable_type, :tipable_id, :sender_id

  scope :select_tips_by_tip_type,
         lambda { |tip_type|where(["tip_type=?",tip_type])  }
  scope :select_tips_by_tipable_type_and_tipable_id,
         lambda { |tipable_type,tipable_id|where(["tipable_type=? AND tipable_id=?",tipable_type,tipable_id])  }
  belongs_to :user
end
