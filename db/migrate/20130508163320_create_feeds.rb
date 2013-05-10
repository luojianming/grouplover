class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :model_name
      t.integer :item_id
      t.integer :user_id

      t.timestamps
    end
  end
end
