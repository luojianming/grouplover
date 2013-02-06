class RenameParentIdInPrivateMessage < ActiveRecord::Migration
  change_table :private_messages do |t|
    t.rename :parent_id, :original_message_id
  end
end
