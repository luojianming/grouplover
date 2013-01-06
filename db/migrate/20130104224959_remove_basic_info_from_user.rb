class RemoveBasicInfoFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :head_url
    remove_column :users, :hobby
    remove_column :users, :style
    remove_column :users, :lover_style
    remove_column :users, :description
  end

  def down
    add_column :users, :description, :string
    add_column :users, :lover_style, :string
    add_column :users, :style, :string
    add_column :users, :hobby, :string
    add_column :users, :head_url, :string
  end
end
