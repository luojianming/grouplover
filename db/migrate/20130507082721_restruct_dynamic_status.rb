class RestructDynamicStatus < ActiveRecord::Migration
  def up
    remove_column :dynamic_statuses, :sender_id
    remove_column :dynamic_statuses, :receiver_id
    remove_column :dynamic_statuses, :original_status_id
  end

  def down
    add_column :dynamic_statuses, :sender_id, :integer
    add_column :dynamic_statuses, :receiver_id, :integer
    add_column :dynamic_statuses, :original_status_id, :integer
  end
end
