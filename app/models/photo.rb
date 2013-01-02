class Photo < ActiveRecord::Base
  attr_accessible :album_id, :description, :image, :name
  belongs_to :album
  mount_uploader :image, ImageUploader
end
