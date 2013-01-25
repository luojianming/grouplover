class RenameTableGroupUserships < ActiveRecord::Migration
  change_table :group_memberships do |t|
    t.rename :user_id, :member_id
  end
end
