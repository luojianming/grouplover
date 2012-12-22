class RemoveSomeColumnsFromProfiles < ActiveRecord::Migration
  def up
    remove_column :profiles, :sex
    remove_column :profiles, :hometown
    add_column :profiles, :profession, :string
  end

  def down
    add_column :profiles, :sex, :boolean
    add_column :profiles, :hometown, :string
    remove_column :profiles, :profession
  end
end
