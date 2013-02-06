class AddStatusToPrivateMessage < ActiveRecord::Migration
  def change
    add_column :private_messages, :status, :string
  end
end
