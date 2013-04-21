class AddActivityToGroupGroupship < ActiveRecord::Migration
  def change
    add_column :group_groupships, :activity, :string
  end
end
