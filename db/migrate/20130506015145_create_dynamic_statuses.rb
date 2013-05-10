class CreateDynamicStatuses < ActiveRecord::Migration
  def change
    create_table :dynamic_statuses do |t|
      t.integer :user_id
      t.string :content
      t.integer :sender_id
      t.integer :receiver_id
      t.integer :original_status_id

      t.timestamps
    end
  end
end
