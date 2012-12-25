class CreateGroupInvitationships < ActiveRecord::Migration
  def change
    create_table :group_invitationships do |t|
      t.string :applied_group_id
      t.string :status

      t.timestamps
    end
  end
end
