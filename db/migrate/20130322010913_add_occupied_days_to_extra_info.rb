class AddOccupiedDaysToExtraInfo < ActiveRecord::Migration
  def change
    add_column :extra_infos, :occupied_days, :integer
  end
end
