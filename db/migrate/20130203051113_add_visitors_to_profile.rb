class AddVisitorsToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :vistors, :string
  end
end
