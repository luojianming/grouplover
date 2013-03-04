class AddHeadUrlToAuthorization < ActiveRecord::Migration
  def change
    add_column :authorizations, :head_url, :string
  end
end
