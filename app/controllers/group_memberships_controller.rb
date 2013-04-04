#encoding: utf-8
class GroupMembershipsController < ApplicationController
  before_filter :authenticate_user!
  def accept
    debugger
    @member = current_user
    @group_id= params[:group]
    @group = Group.find(@group_id)
    unless @member.nil?
      if GroupMembership.accept(@member, @group_id)
        @group.members.each do |member|
          if member != @member
            member.tips.create(:tip_type => "group_membership",:content => @member.name + "接受了小组" + @group.name + "发出的邀请")
          end
        end
        @group.team_leader.tips.create(:content => @member.name + "接受了小组" + @group.name + "发出的邀请")
        flash[:notice] = "加入成功"
      else
        flash[:notice] = "加入失败"
      end
    end

    redirect_to groups_user_path(current_user)
  end

  def reject
    @member = current_user
    @group = params[:group]
    unless @member.nil?
      if GroupMembership.reject(@member, @group)
        flash[:notice] = "拒绝成功"
      else 
        flash[:notice] = "拒绝失败"
      end
    end
    redirect_to user_path(current_user)
  end

end
