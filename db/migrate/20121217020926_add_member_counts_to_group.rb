class AddMemberCountsToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :member_counts, :integer
  end
end
