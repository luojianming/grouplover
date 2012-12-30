class ChangelabelsInGroup < ActiveRecord::Migration
  def up
    change_column :groups, :labels, :text
  end

  def down
    change_column :groups, :labels, :string
  end
end
