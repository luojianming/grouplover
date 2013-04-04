class RenameTypeInTip < ActiveRecord::Migration
  def up
    rename_column :tips, :type, :tip_type
  end

  def down
  end
end
