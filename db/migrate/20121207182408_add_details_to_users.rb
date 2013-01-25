class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sex, :boolean
    add_column :users, :birthday, :string
    add_column :users, :hometown, :string
    add_column :users, :location, :string
    add_column :users, :school, :string
  end
end
