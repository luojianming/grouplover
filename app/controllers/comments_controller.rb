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
    elsif @type == "dynamic_status_comment"
      @receiver_id = params[:receiver_id] if params[:receiver_id]
      @commentable = DynamicStatus.find(params[:dynamic_status_id].to_i)
    elsif @type == "group_comment"
      @receiver_id = params[:receiver_id] if params[:receiver_id]
      @commentable = Group.find(params[:group_id].to_i)
    elsif @type == "group_invitationship_comment"
      @receiver_id = params[:receiver_id] if params[:receiver_id]
      @commentable = GroupInvitationship.find(params[:group_invitationship_id].to_i)
    elsif @type == "group_groupship_comment"
      @receiver_id = params[:receiver_id] if params[:receiver_id]
      @commentable = GroupGroupship.find(params[:group_groupship_id].to_i)
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
    elsif @commentable_type == "DynamicStatus"
      @commentable = DynamicStatus.find(params[:dynamic_status_id])
    elsif @commentable_type == "GroupInvitationship"
      @commentable = GroupInvitationship.find(params[:group_invitationship_id])
    elsif @commentable_type == "GroupGroupship"
      @commentable = GroupGroupship.find(params[:group_groupship_id])
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
      if receiver_id && receiver_id.size > 0
        receiver = User.find(receiver_id)
        if @commentable_type == "DynamicStatus" || @feedable_type == "DynamicStatus"
          receiver.tips.create(:tip_type => "comments",
                               :tipable_type => "DynamicStatus",
                               :tipable_id => @commentable.id,
                               :sender_id => sender_id)
        elsif @commentable_type == "Photo" || @feedable_type == "Photo"
          receiver.tips.create(:tip_type => "comments",
                               :tipable_type => "Photo",
                               :tipable_id => @commentable.id,
                               :sender_id => sender_id)
        elsif @commentable_type == "Group" || @feedable_type == "Group"
          receiver.tips.create(:tip_type => "comments",
                               :tipable_type => "Group",
                               :tipable_id => @commentable.id,
                               :sender_id => sender_id)
        elsif @commentable_type == "Invitation" || @feedable_type == "Invitation"
          receiver.tips.create(:tip_type => "comments",
                               :tipable_type => "Invitation",
                               :tipable_id => @commentable.id,
                               :sender_id => sender_id)
        elsif @commentable_type == "GroupInvitationship" || @feedable_type == "GroupInvitationship"
          receiver.tips.create(:tip_type => "comments",
                               :tipable_type => "GroupInvitationship",
                               :tipable_id => @commentable.id,
                               :sender_id => sender_id)
        elsif @commentable_type == "GroupGroupship" || @feedable_type == "GroupGroupship"
          receiver.tips.create(:tip_type => "comments",
                               :tipable_type => "GroupGroupship",
                               :tipable_id => @commentable.id,
                               :sender_id => sender_id)
        end
      else
        if @commentable_type == "DynamicStatus" || @feedable_type == "DynamicStatus"
          @commentable.user.tips.create(:tip_type => "comments",
                                        :tipable_type => "DynamicStatus",
                                        :tipable_id => @commentable.id,
                                        :sender_id => sender_id)
        elsif @commentable_type == "Photo" || @feedable_type == "Photo"
          @commentable.album.user.tips.create(:tip_type => "comments",
                                              :tipable_type => "Photo",
                                              :tipable_id => @commentable.id,
                                              :sender_id => sender_id)
        elsif @commentable_type == "Group" || @feedable_type == "Group"
          @commentable.team_leader.tips.create(:tip_type => "comments",
                                               :tipable_type => "Group",
                                               :tipable_id => @commentable.id,
                                               :sender_id => sender_id)
          @commentable.members.each do |member|
            member.tips.create(:tip_type => "comments",
                               :tipable_type => "Group",
                               :tipable_id => @commentable.id,
                               :sender_id => sender_id)
          end
        elsif @commentable_type == "Invitation" || @feedable_type == "Invitation"
          initiate_group = @commentable.initiate_group
          initiate_group.team_leader.tips.create(:tip_type => "comments",
                                                 :tipable_type => "Invitation",
                                                 :tipable_id => @commentable.id,
                                                 :sender_id => sender_id)
          initiate_group.members.each do |member|
            member.tips.create(:tip_type => "comments",
                               :tipable_type => "Invitation",
                               :tipable_id => @commentable.id,
                               :sender_id => sender_id)
          end
        elsif @commentable_type == "GroupInvitationship" || @feedable_type == "GroupInvitationship"
          initiate_group = @commentable.invitation.initiate_group
          applied_group = @commentable.applied_group
          initiate_group.team_leader.tips.create(:tip_type => "comments",
                                                 :tipable_type => "GroupInvitationship",
                                                 :tipable_id => @commentable.id,
                                                 :sender_id => sender_id)
          applied_group.team_leader.tips.create(:tip_type => "comments",
                                                :tipable_type => "GroupInvitationship",
                                                :tipable_id => @commentable.id,
                                                :sender_id => sender_id)
          (initiate_group.members | applied_group.members).each do |member|
            member.tips.create(:tip_type => "comments",
                               :tipable_type => "GroupInvitationship",
                               :tipable_id => @commentable.id,
                               :sender_id => sender_id)
          end
        elsif @commentable_type == "GroupGroupship" || @feedable_type == "GroupGroupship"
          initiate_group = @commentable.applied_group
          target_group = @commentable.target_group
          initiate_group.team_leader.tips.create(:tip_type => "comments",
                                                 :tipable_type => "GroupGroupship",
                                                 :tipable_id => @commentable.id,
                                                 :sender_id => sender_id)
          target_group.team_leader.tips.create(:tip_type => "comments",
                                               :tipable_type => "GroupGroupship",
                                               :tipable_id => @commentable.id,
                                               :sender_id => sender_id)
          (target_group.members | applied_group.members).each do |member|
            member.tips.create(:tip_type => "comments",
                               :tipable_type => "GroupGroupship",
                               :tipable_id => @commentable.id,
                               :sender_id => sender_id)
          end
        end
      end
    end
  end
end
