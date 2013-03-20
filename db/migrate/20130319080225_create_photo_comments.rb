class CreatePhotoComments < ActiveRecord::Migration
  def change
    create_table :photo_comments do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.string :content
      t.integer :photo_id
      t.string :status

      t.timestamps
    end
  end
end
