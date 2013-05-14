class AddColumnsToTip < ActiveRecord::Migration
  def change
    add_column :tips, :tipable_type, :string
    add_column :tips, :tipable_id, :integer
  end
end
