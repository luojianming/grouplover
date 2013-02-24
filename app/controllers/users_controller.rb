#encoding: utf-8
require 'will_paginate/array'
class UsersController < ApplicationController
  before_filter :authenticate_user!
  def index
    @users = User.by_user_location(params[:user_location]) if params[:user_location]
    if @user == nil
      @users = User.by_hometown(params[:user_hometown]) if params[:user_hometown]
    else
      @users = @users.by_hometown(params[:user_hometown]) if params[:user_hometown]
    end
    if @user == nil
      @users = User.by_school(params[:user_school]) if params[:user_school]
    else
      @users = @users.by_school(params[:user_school]) if params[:user_school]
    end
    if @users == nil
      @users = User.all.paginate(page: params[:page], :per_page => 12)
    else
      @users = @users.paginate(page: params[:page], :per_page => 12)
    end
  end

  def show
    begin
      @user = User.find(params[:id])
      @following_invitations = Invitation.initiated_by_users_followed_by(@user)
      render 'show_following_invitations'
=begin
      if (current_user != @user)
        extra_info = @user.extra_info ||= @user.create_extra_info()
        vistors = extra_info.vistors.to_s
        if vistors.length == 0
          vistors += current_user.id.to_s
        else
          vistors = current_user.id.to_s + "," + vistors
        end
        extra_info.vistors = vistors
        extra_info = @user.build_extra_info(vistors);
        extra_info.save
      end
=end
    rescue
      redirect_to users_path, :alert => "the page is not exist"
    end
  end
  
  def update
    authorize! :update, @user, :message => 'Not authorized as an administrator.'
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user], :as => :admin)
      redirect_to users_path, :notice => "User updated."
      @current_ability = nil
      @current_user = nil
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end
    
  def destroy
    authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end

  def following
    @label = "关注的人"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @label = "粉丝"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def friends
    @label = "好友"
    @user = User.find(params[:id])
    @friends = @user.find_friends()
    @users = @friends.paginate(page: params[:page])
    render 'show_follow'
  end

  def groups
    @user = User.find(params[:id])
    @mygroups = @user.mygroups
    @group_memberships = @user.group_memberships
    @groups = []
    @group_memberships.each do |gm|
      @groups << gm.group
    end
    render 'show_group'
  end

  def following_invitations
    @user = User.find(params[:id])
    @following_invitations = Invitation.initiated_by_users_followed_by(@user)
    render 'show_following_invitations'
  end

  def my_invitations
    @user = User.find(params[:id])
    @my_invitations = Invitation.initiated_by_user(@user)
    render 'show_my_invitations'
  end

  def received_invitations
    @user = User.find(params[:id])
    @my_invitations = Invitation.initiated_by_user(@user)
    @ships = Hash.new
    @my_invitations.each do |my_invitation|
      if my_invitation.status != "active"
        @invitation_ships = GroupInvitationship.find_all_by_invitation_id(my_invitation.id)
        @ships[my_invitation.id] = @invitation_ships
      end
    end
    render 'show_received_invitation'
  end

  def pending_requests
    @user = User.find(params[:id])
    @pending_requests = GroupMembership.find_all_by_member_id_and_status(
                        @user.id, "pending")
    render 'show_pending_requests'
  end

  def albums
    @user = User.find(params[:id])
    @albums = @user.albums
    render 'show_album'
  end


  def my_private_messages
    @user = User.find(params[:id])
    @private_messages_original = PrivateMessage.related_messages(@user).original_messages
    @private_messages_original = @private_messages_original.paginate(page: params[:page])
    render 'show_private_messages'
  end
end
