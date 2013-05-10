class Photo < ActiveRecord::Base
  attr_accessible :album_id, :description, :image, :name, :number
  belongs_to :album, :counter_cache => true
  has_many :comments, :as => :commentable, :dependent => :destroy
  mount_uploader :image, ImageUploader

  validates :album_id, :presence => true

  before_create :default_name

  after_save do |photo|
    user = photo.album.user
    feed = user.feeds.build(:model_name => "Photo",
                            :item_id => id)
    feed.save
  end
  def default_name
    self.name ||= File.basename(image.filename, '.*').titleize if image
  end
end
