class Photo < ActiveRecord::Base
  attr_accessible :album_id, :description, :image, :name, :number
  belongs_to :album, :counter_cache => true
  mount_uploader :image, ImageUploader

  validates :album_id, :presence => true

  before_create :default_name
    def default_name
      self.name ||= File.basename(image.filename, '.*').titleize if image
    end
end
