class ChangeSexFormatInProfile < ActiveRecord::Migration
  def up
    change_column :profiles, :sex, :string
  end

  def down
    change_column :profiles, :sex, :boolean
  end
end

