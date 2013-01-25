class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :name
      t.integer :album_id
      t.string :description
      t.string :image

      t.timestamps
    end
  end
end
