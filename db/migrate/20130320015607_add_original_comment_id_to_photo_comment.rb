class AddOriginalCommentIdToPhotoComment < ActiveRecord::Migration
  def change
    add_column :photo_comments, :original_comment_id, :integer
  end
end
