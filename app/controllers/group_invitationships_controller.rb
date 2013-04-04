#encoding: utf-8
class GroupInvitationshipsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :one_group_can_apply_the_invitation_only_one_time, :only => :create
  before_filter :the_members_of_applied_group_should_be_equal_to_invitation , :only => :create
  def create
    @applied_group = Group.find(params[:group_invitationship][:applied_group_id])
    @invitation = Invitation.find(params[:group_invitationship][:invitation_id])
    @description = params[:group_invitationship][:description]
    if @applied_group.sex == @invitation.initiate_group.sex
      flash[:error] = "申请失败，你只能参加异性朋友发起的活动哦"
      redirect_to root_path
      return false
    end
=begin
    if @applied_group.can_applied?(@invitation)
      @applied_group.applied!(@invitation, @description)
      respond_to do |format|
        format.html { redirect_to root_path, :notice => "申请成功"}
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path, :notice => "申请失败，group中已经有成员申请了该invitation了"}
        format.js
      end
    end
=end
    @applied_group.applied!(@invitation, @description)
    respond_to do |format|
      format.html { redirect_to sended_requests_user_path(current_user), :notice => "申请成功"}
      format.js
    end
  end

  def accept
    @applied_group_id = params[:applied_group]
    @invitation_id = params[:invitation]
    GroupInvitationship.accept(@applied_group_id,@invitation_id)
    @invitation = Invitation.find(@invitation_id)
    @applied_group = Group.find(@applied_group_id)
    @applied_group.members.each do |member|
      member.tips.create(:tip_type => "group_invitationship", :content => @invitation.initiate_group.name + "接受了你们的申请")
    end

    @applied_group.team_leader.tips.create(:tip_type => "group_invitationship",
                                           :content => @invitation.initiate_group.name + "接受了你们的申请")
    redirect_to conversations_path
  end

  def one_group_can_apply_the_invitation_only_one_time
    @applied_group = Group.find(params[:group_invitationship][:applied_group_id])
    @invitation = Invitation.find(params[:group_invitationship][:invitation_id])
    if @invitation.applied_groups.include?(@applied_group)
      flash[:error]="该组已经申请过该活动了"
      redirect_to root_path
      return false
    end
  end

  def the_members_of_applied_group_should_be_equal_to_invitation
    @applied_group = Group.find(params[:group_invitationship][:applied_group_id])
    @invitation = Invitation.find(params[:group_invitationship][:invitation_id])
    if @applied_group.members.count != @invitation.initiate_group.members.count
      flash[:error] = "两个小组的成员数目必须相等哦"
      redirect_to root_path
      return false
    end
  end
end
