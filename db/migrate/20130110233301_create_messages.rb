class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content
      t.integer :conversation_id
      t.integer :sender_id

      t.timestamps
    end
  end
end
