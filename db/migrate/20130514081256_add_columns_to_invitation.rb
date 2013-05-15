class AddColumnsToInvitation < ActiveRecord::Migration
  def change
    add_column :invitations, :image, :string
    add_column :invitations, :invitation_type, :string
  end
end
