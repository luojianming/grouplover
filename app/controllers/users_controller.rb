#encoding: utf-8
require 'will_paginate/array'
class UsersController < ApplicationController
  before_filter :authenticate_user!
  def index
    per_page = 100
    if @users == nil
      @users = User.by_user_location(params[:user_location]).search(:per_page => per_page) if params[:user_location]
    else
      @users = @users.by_user_location(params[:user_location]).search(:per_page => per_page) if params[:user_location]
    end
    if @users == nil
      @users = User.by_hometown(params[:user_hometown]).search(:per_page => per_page) if params[:user_hometown]
    else
      @users = @users.by_hometown(params[:user_hometown]).search(:per_page => per_page) if params[:user_hometown]
    end
    if @users == nil
      @users = User.by_sex(params[:user_sex]).search(:per_page => per_page) if params[:user_sex] && params[:user_sex].to_s.size != 0
    else
      @users = @users.by_sex(params[:user_sex]).search(:per_page => per_page) if params[:user_sex] && params[:user_sex].to_s.size != 0
    end
    if @users == nil
      @users = User.by_school(params[:user_school]).search(:per_page => per_page) if params[:user_school] && params[:user_school].to_s.size != 0
    else
      @users = @users.by_school(params[:user_school]).search(:per_page => per_page) if params[:user_school] && params[:user_school].to_s.size != 0
    end
    if params[:search] != nil
       @users = User.search(params[:search],:per_page => per_page)
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
      if current_user == @user
        @following_invitations = Invitation.initiated_by_users_followed_by(@user)
        render 'show_following_invitations'
      else
        @my_invitations = Invitation.initiated_by_user(@user)
        render 'show_my_invitations'
      end
    rescue
      redirect_to root_path, :alert => "您访问的页面不存在"
    end
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
    @users = @user.followed_users.paginate(page: params[:page], :per_page => 12)
    render 'show_follow'
  end

  def followers
    @label = "粉丝"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page], :per_page => 12)
    render 'show_follow'
  end

  def friends
    @label = "好友"
    @user = User.find(params[:id])
    @friends = @user.find_friends()
    @users = @friends.paginate(page: params[:page], :per_page => 12)
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
    @ships = GroupInvitationship.find_received_invitations_by_user(@user)
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
    @private_messages_original = @private_messages_original.paginate(page: params[:page], :per_page => 10)
    render 'show_private_messages'
  end

  def visitors
    @label = "最近来访"
    @user = User.find(params[:id])
    if @user.extra_info == nil
      @user.extra_info = @user.create_extra_info()
    end
    if @user.extra_info.visitors == nil 
      @user.extra_info.visitors = ""
    end
    @users = []
    @user_ids_array = @user.extra_info.visitors.split(",")
    @user_ids_array.each do |user_id|
      @users << User.find(user_id)
    end
    @users = @users.paginate(page: params[:page], :per_page => 12)
    render 'users/show_visitors'
  end
end
