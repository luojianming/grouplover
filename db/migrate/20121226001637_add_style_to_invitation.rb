class AddStyleToInvitation < ActiveRecord::Migration
  def change
    add_column :invitations, :style, :string
  end
end
