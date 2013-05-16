class RemoveColumnsFromInvitation < ActiveRecord::Migration
  def up
    remove_column :invitations, :lover_style
    remove_column :invitations, :style
  end

  def down
    add_column :invitations, :style, :string
    add_column :invitations, :lover_style, :string
  end
end
