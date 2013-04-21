class CreateGroupGroupships < ActiveRecord::Migration
  def change
    create_table :group_groupships do |t|
      t.integer :applied_group_id
      t.integer :target_group_id
      t.string :time
      t.string :location
      t.string :description

      t.timestamps
    end
  end
end
