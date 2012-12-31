class AddDetailsToGroupInvitationship < ActiveRecord::Migration
  def change
    add_column :group_invitationships, :description, :string
  end
end
