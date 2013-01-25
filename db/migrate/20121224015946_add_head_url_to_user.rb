class AddHeadUrlToUser < ActiveRecord::Migration
  def change
    add_column :users, :head_url, :string
  end
end
