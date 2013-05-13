#encoding: utf-8
class CommentsController < ApplicationController
  def new
    @type = params[:type]
    if params[:general_feed_id]
      @general_feed_id = params[:general_feed_id]
      @feed = Feed.find(@general_feed_id)
      @feedable_type = @feed.feedable_type
    end
    if @feedable_type == "Photo"
      @receiver_id = params[:receiver_id] if params[:receiver_id]
      @commentable = Photo.find(params[:feed_id].to_i)
    elsif @type == "photo_comment"
      @receiver_id = params[:receiver_id] if params[:receiver_id]
      @commentable = Photo.find(params[:photo_id].to_i)
    elsif @type == "invitation_comment"
      @receiver_id = params[:receiver_id] if params[:receiver_id]
      @commentable = Invitation.find(params[:invitation_id].to_i)
    elsif @type == "group_comment"
      @receiver_id = params[:receiver_id] if params[:receiver_id]
      @commentable = Group.find(params[:group_id].to_i)
    elsif @feedable_type == "DynamicStatus"
      @receiver_id = params[:receiver_id] if params[:receiver_id]
      @commentable = DynamicStatus.find(params[:feed_id].to_i)
    elsif @feedable_type == "Group"
      @receiver_id = params[:receiver_id] if params[:receiver_id]
      @commentable = Group.find(params[:feed_id].to_i)
    elsif @feedable_type == "Invitation"
      @receiver_id = params[:receiver_id] if params[:receiver_id]
      @commentable = Invitation.find(params[:feed_id].to_i)
    elsif @feedable_type == "GroupInvitationship"
      @receiver_id = params[:receiver_id] if params[:receiver_id]
      @commentable = GroupInvitationship.find(params[:feed_id].to_i)
    elsif @feedable_type == "GroupGroupship"
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
      @feedable_type = @feed.feedable_type
    end
    content = params[:content]
    if @commentable_type == "Photo"
      @commentable = Photo.find(params[:photo_id])
    elsif @commentable_type == "Invitation"
      @commentable = Invitation.find(params[:invitation_id])
    elsif @commentable_type == "Group"
      @commentable = Group.find(params[:group_id])
    elsif @feedable_type == "DynamicStatus"
      @commentable = DynamicStatus.find(params[:feed_id])
    elsif @feedable_type == "Photo"
      @commentable = Photo.find(params[:feed_id])
    elsif @feedable_type == "Group"
      @commentable = Group.find(params[:feed_id])
    elsif @feedable_type == "Invitation"
      @commentable = Invitation.find(params[:feed_id])
    elsif @feedable_type == "GroupInvitationship"
      @commentable = GroupInvitationship.find(params[:feed_id])
    elsif @feedable_type == "GroupGroupship"
      @commentable = GroupGroupship.find(params[:feed_id])
    end
    @comment = @commentable.comments.build(:sender_id => sender_id,
                                           :receiver_id => receiver_id,
                                           :content => content)

    if @comment.save
      receiver = User.find(receiver_id)
      if @commentable_type == "DynamicStatus"
        receiver.tips.create(:tip_type => "comments",
                             :content => User.find(sender_id).name + "在状态中回复了你")
      elsif @commentable_type == "Photo"
        receiver.tips.create(:tip_type => "comments",
                             :content => User.find(sender_id).name + "在照片"+@commentable.name+"中回复了你")
      elsif @commentable_type == "Group"
        receiver.tips.create(:tip_type => "comments",
                             :content => User.find(sender_id).name + "在群组"+@commentable.name+"中回复了你")
      end
    end
  end
end
