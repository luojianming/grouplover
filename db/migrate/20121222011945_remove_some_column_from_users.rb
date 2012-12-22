class RemoveSomeColumnFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :birthday
    remove_column :users, :school
  end

  def down
    add_column :users, :birthday, :string
    add_column :users, :school, :string
  end
end
