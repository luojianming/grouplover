#encoding: utf-8
class ConversationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :should_be_related_conversationer, :only => :create
  def index
  end

  def create
    if params[:group] != nil
      @conversationer = Group.find(params[:group])
    end
    if params[:invitation] != nil
      @conversationer = Invitation.find(params[:invitation])
    end
  end

  def should_be_related_conversationer
    if params[:group] != nil
      @group = Group.find(params[:group])
      @related_groups = current_user.related_groups() 
      if !@related_groups.include?(@group)
        redirect_to root_path, :notice => '您无权访问该页'
      end
    end

    if params[:invitation] != nil
      @invitation = Invitation.find(params[:invitation])
      @related_invitations = current_user.related_active_invitations() 
      if !@related_invitations.include?(@invitation)
        redirect_to root_path, :notice => '您无权访问该页'
      end
    end
    
  end

  def destroy
    @id = params[:id]
    @conversation = Conversation.find(@id)
  end
end
