#encoding: utf-8
class GroupMembershipsController < ApplicationController
  before_filter :authenticate_user!
  def accept
    @member = current_user
    @group = params[:group]
    unless @member.nil?
      if GroupMembership.accept(@member, @group)
        flash[:notice] = "加入成功"
      else
        flash[:notice] = "加入失败"
      end
    end

    redirect_to user_path(current_user)
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
