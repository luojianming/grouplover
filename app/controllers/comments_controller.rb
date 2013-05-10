class CommentsController < ApplicationController
  def new
    @type = params[:type]
    if params[:general_feed_id]
      @general_feed_id = params[:general_feed_id]
      @feed = Feed.find(@general_feed_id)
      @model_name = @feed.model_name
    end
    if @model_name == "Photo"
      @receiver_id = params[:receiver_id] if params[:receiver_id]
      @commentable = Photo.find(params[:feed_id].to_i)
    elsif @type == "photo_comment"
      @receiver_id = params[:receiver_id] if params[:receiver_id]
      @commentable = Photo.find(params[:photo_id].to_i)
    elsif @model_name == "DynamicStatus"
      @receiver_id = params[:receiver_id] if params[:receiver_id]
      @commentable = DynamicStatus.find(params[:feed_id].to_i)
    elsif @model_name == "Group"
      @receiver_id = params[:receiver_id] if params[:receiver_id]
      @commentable = Group.find(params[:feed_id].to_i)
    elsif @model_name == "Invitation"
      @receiver_id = params[:receiver_id] if params[:receiver_id]
      @commentable = Invitation.find(params[:feed_id].to_i)
    elsif @model_name == "GroupInvitationship"
      @receiver_id = params[:receiver_id] if params[:receiver_id]
      @commentable = GroupInvitationship.find(params[:feed_id].to_i)
    elsif @model_name == "GroupGroupship"
      @receiver_id = params[:receiver_id] if params[:receiver_id]
      @commentable = GroupGroupship.find(params[:feed_id].to_i)
    end
  end

  def create
    @commentable_type = params[:commentable_type]
    sender_id = current_user.id
    if params[:receiver_id]
      receiver_id = params[:receiver_id]
    end
    if params[:general_feed_id]
      @general_feed_id = params[:general_feed_id]
      @feed = Feed.find(@general_feed_id)
      @model_name = @feed.model_name
    end
    content = params[:content]
    if @commentable_type == "Photo"
      @commentable = Photo.find(params[:photo_id])
    elsif @model_name == "DynamicStatus"
      @commentable = DynamicStatus.find(params[:feed_id])
    elsif @model_name == "Photo"
      @commentable = Photo.find(params[:feed_id])
    elsif @model_name == "Group"
      @commentable = Group.find(params[:feed_id])
    elsif @model_name == "Invitation"
      @commentable = Invitation.find(params[:feed_id])
    elsif @model_name == "GroupInvitationship"
      @commentable = GroupInvitationship.find(params[:feed_id])
    elsif @model_name == "GroupGroupship"
      @commentable = GroupGroupship.find(params[:feed_id])
    end
    @comment = @commentable.comments.build(:sender_id => sender_id,
                                           :receiver_id => receiver_id,
                                           :content => content)
    @comment.save
  end
end
