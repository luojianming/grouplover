class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :commentable_id
      t.string :commentable_type
      t.integer :sender_id
      t.integer :receiver_id

      t.timestamps
    end
  end
end
