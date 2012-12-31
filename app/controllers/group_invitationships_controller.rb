#encoding: utf-8
class GroupInvitationshipsController < ApplicationController
  def create
    @applied_group = Group.find(params[:group_invitationship][:applied_group_id])
    @invitation = Invitation.find(params[:group_invitationship][:invitation_id])

    if @applied_group.can_applied?(@invitation)
      @applied_group.applied!(@invitation)
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
  end

  def destroy

  end
end
