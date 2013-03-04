class RemoveImageUrlFromInvitation < ActiveRecord::Migration
  def up
    remove_column :invitations, :image_url
  end

  def down
    add_column :invitations, :image_url, :string
  end
end
