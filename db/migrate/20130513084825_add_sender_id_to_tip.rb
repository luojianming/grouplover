class AddSenderIdToTip < ActiveRecord::Migration
  def change
    add_column :tips, :sender_id, :integer
  end
end
