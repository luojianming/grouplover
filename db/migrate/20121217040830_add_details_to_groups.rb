class AddDetailsToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :sex, :boolean
    add_column :groups, :location, :string
    add_column :groups, :founded_time, :string
    add_column :groups, :labels, :string
  end
end
