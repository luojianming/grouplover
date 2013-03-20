class PhotoCommentsController < ApplicationController
  def create
    @photo = Photo.find(params[:photo_id])
    sender_id = current_user.id
    if params[:original_comment_id] == nil
      receiver_id = @photo.album.user.id
    else
      receiver_id = PhotoComment.find(params[:original_comment_id].to_i).sender.id
    end
    content = params[:content]
    @comment = @photo.photo_comments.build(:sender_id => sender_id,
                                     :receiver_id => receiver_id,
                                     :content => content,
                                     :status => "unread")
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @photo }
        format.js
      end
    end
  end

  def new
    @comment = PhotoComment.find(params[:original_comment_id]) if params[:original_comment_id]
    @photo = Photo.find(params[:photo_id])
  end
end
