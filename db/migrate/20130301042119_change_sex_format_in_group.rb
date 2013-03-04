class ChangeSexFormatInGroup < ActiveRecord::Migration
  def up
    change_column :groups, :sex, :string
  end

  def down
    change_column :groups, :sex, :boolean
  end
end
