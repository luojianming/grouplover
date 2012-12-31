#encoding: utf-8
class GroupInvitationshipsController < ApplicationController
  def create
    @applied_group = Group.find(params[:group_invitationship][:applied_group_id])
    @invitation = Invitation.find(params[:group_invitationship][:invitation_id])

    @applied_group.applied!(@invitation)

    respond_to do |format|
      format.html { redirect_to root_path, :notice => "申请成功"}
      format.js
    end
  end

  def destroy

  end
end
