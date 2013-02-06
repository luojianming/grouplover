class AddParentIdToPrivateMessage < ActiveRecord::Migration
  def change
    add_column :private_messages, :parent_id, :integer
  end
end
