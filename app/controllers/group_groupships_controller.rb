#encoding: utf-8
class GroupGroupshipsController < ApplicationController
  include ApplicationHelper
  before_filter :authenticate_user!

  def show
    @group_groupship = GroupGroupship.find(params[:id])
  end
  def create
    @target_group_id = params[:group_groupship][:target_group_id]
    params[:group_groupship][:status] = "pending"
    @applied_group_id = params[:group_groupship][:applied_group_id]
    @target_group = Group.find(@target_group_id)
    @applied_group = Group.find(@applied_group_id)
    @target_group_members = @target_group.members
    @applied_group_members = @applied_group.members
    if (@target_group_members & @applied_group_members).size > 0 ||
        @target_group_members.include?(@applied_group.team_leader) ||
        @applied_group_members.include?(@target_group.team_leader)
      respond_to do |format|
        format.js { render 'error.js.erb' }
      end
      return true
    end
    g = GroupGroupship.new(params[:group_groupship])
    if g.save
      @applied_group.members.each do |member|
        member.tips.create(:tip_type => "apply_group_groupship",
                           :content => "您所在的group"+@applied_group.name+"向group"+@target_group.name+"发出了邀请")
      end
      @target_group.members.each do |member|
        member.tips.create(:tip_type => "target_group_groupship",
                           :content => "您所在的group"+@target_group.name+"收到了"+@applied_group.name+"发来的邀请")
      end
      @target_group.team_leader.tips.create(:tip_type => "target_group_groupship",
                                            :content => "您所在的group"+@target_group.name+"收到了"+@applied_group.name+"发来的邀请")
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @groupship = GroupGroupship.find(params[:group_groupship].to_i)
    @groupship.destroy
    redirect_to received_invitations_user_path(current_user), :notice => "忽略成功"
  end

  def accept
    @group_groupship = GroupGroupship.find(params[:group_groupship])
    @applied_group = Group.find(@group_groupship.applied_group_id)
    @target_group = Group.find(@group_groupship.target_group_id)
    begin
      GroupGroupship.transaction do
        @group_groupship.accept()
        @group_groupship.create_conversation()
        @target_group.members.each do |member|
          member.tips.create(:tip_type => "target_accept_groupship",
                             :content => "您所在的group"+@target_group.name+"接受了"+@applied_group.name+"发来的邀请")
        end
        @applied_group.members.each do |member|
          member.tips.create(:tip_type => "apply_accept_groupship",
                             :content => "group"+@target_group.name+"接受了"+@applied_group.name+"发出的邀请")
        end
        @applied_group.team_leader.tips.create(:tip_type => "apply_accept_groupship",
                                               :content => "group"+@target_group.name+"接受了"+@applied_group.name+"发出的邀请")

      end
    end
    redirect_to conversations_path
  end
end
