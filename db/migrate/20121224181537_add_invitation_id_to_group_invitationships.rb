class AddInvitationIdToGroupInvitationships < ActiveRecord::Migration
  def change
    add_column :group_invitationships, :invitation_id, :integer
  end
end
