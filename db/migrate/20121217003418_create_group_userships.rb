class CreateGroupUserships < ActiveRecord::Migration
  def change
    create_table :group_userships do |t|
      t.integer :group_id
      t.integer :user_id

      t.timestamps
    end
  end
end
