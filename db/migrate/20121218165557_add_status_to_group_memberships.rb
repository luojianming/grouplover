class AddStatusToGroupMemberships < ActiveRecord::Migration
  def change
    add_column :group_memberships, :status, :string
  end
end
