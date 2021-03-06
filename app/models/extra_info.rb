class ExtraInfo < ActiveRecord::Base
  attr_accessible  :visitors, :occupied_days
  validates :user_id, :presence => true
  belongs_to :user

  def self.add(extra_info, visitor)
    if extra_info.visitors != nil
      visitor_array = extra_info.visitors.split(",")
      extra_info.counts = extra_info.counts.to_i + 1
      visitor_array.delete(visitor.id.to_s)
      extra_info.visitors = visitor_array.join(",")
      extra_info.visitors = visitor.id.to_s + ',' + extra_info.visitors
      extra_info.save
    else
      extra_info.visitors = visitor.id.to_s
      extra_info.counts = extra_info.counts.to_i + 1
      extra_info.save
    end
  end
end
