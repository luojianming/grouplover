class Tip < ActiveRecord::Base
  attr_accessible :content, :user_id,:tip_type

  scope :select_tips_by_tip_type,
         lambda { |tip_type|where(["tip_type=?",tip_type])  }
  belongs_to :user
end
