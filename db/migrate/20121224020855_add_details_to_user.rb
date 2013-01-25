class AddDetailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :hobby, :string
    add_column :users, :lover_style, :string
  end
end
