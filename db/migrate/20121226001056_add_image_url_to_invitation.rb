class AddImageUrlToInvitation < ActiveRecord::Migration
  def change
    add_column :invitations, :image_url, :string
  end
end
