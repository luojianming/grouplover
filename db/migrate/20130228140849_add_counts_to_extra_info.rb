class AddCountsToExtraInfo < ActiveRecord::Migration
  def change
    add_column :extra_infos, :counts, :integer
  end
end
