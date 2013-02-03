class RemoveVisitorsFromProfile < ActiveRecord::Migration
  def up
    remove_column :profiles, :vistors
  end

  def down
    add_column :profiles, :vistors, :string
  end
end
