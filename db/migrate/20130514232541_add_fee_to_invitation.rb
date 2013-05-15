class AddFeeToInvitation < ActiveRecord::Migration
  def change
    add_column :invitations, :fee, :string
  end
end
