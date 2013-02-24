class ChangeImageUrlToImageInGroup < ActiveRecord::Migration
  change_table :groups do |t|
    t.rename :image_url, :image
  end
end
