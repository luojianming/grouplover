class AddStatusToGroupGroupship < ActiveRecord::Migration
  def change
    add_column :group_groupships, :status, :string
  end
end
