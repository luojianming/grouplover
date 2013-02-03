class ExtraInfo < ActiveRecord::Base
  attr_accessible  :visitors
  validates :user_id, :presence => true
  belongs_to :user

  def add(visitor)
    debugger
    if visitors != nil
       visitors = visitor.id.to_s + ',' + visitors
    else
       visitors = visitor.id.to_s
    end
  end
end
