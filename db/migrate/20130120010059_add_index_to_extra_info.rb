class AddIndexToExtraInfo < ActiveRecord::Migration
  def change
	  add_index :extra_infos, :user_id
  end
end
