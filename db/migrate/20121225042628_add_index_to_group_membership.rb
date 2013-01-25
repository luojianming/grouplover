class AddIndexToGroupMembership < ActiveRecord::Migration
  def change
    add_index :group_memberships, [:group_id, :member_id], unique: true
  end
end
