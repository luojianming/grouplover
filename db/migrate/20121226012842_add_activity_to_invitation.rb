class AddActivityToInvitation < ActiveRecord::Migration
  def change
    add_column :invitations, :activity, :string
  end
end
