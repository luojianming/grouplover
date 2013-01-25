class AddPhotosCountToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :photos_count, :integer
  end
end
