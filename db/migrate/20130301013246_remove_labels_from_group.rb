class RemoveLabelsFromGroup < ActiveRecord::Migration
  def up
    remove_column :groups, :labels
  end

  def down
    add_column :groups, :labels, :string
  end
end
