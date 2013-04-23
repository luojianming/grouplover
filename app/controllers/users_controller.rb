#encoding: utf-8
require 'will_paginate/array'
class UsersController < ApplicationController
  include ApplicationHelper
  before_filter :authenticate_user!
  before_filter :store_location!
  before_filter :detect_authorization, :only => [:participate_activities, :received_invitations,
                                                 :sended_requests, :pending_requests, :my_invitations]
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
      @user = User.find(params[:id])
      if current_user == @user
        @following_invitations = Invitation.initiated_by_users_followed_by(@user)
        @followed_groups = User.followed_related_groups(@user)
        render 'show_following_invitations'
      else
        @my_invitations = Invitation.initiated_by_user(@user)
        render 'show_my_invitations'
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
    @user = User.find(params[:id])
    if current_user == @user
      @label = "关注"
    else
      @label = "TA的关注"
    end
    @users = @user.followed_users.paginate(page: params[:page], :per_page => 12)
    render 'show_follow'
  end

  def followers
    @user = User.find(params[:id])
    if current_user == @user
      @label = "粉丝"
    else
      @label = "TA的粉丝"
    end
    @users = @user.followers.paginate(page: params[:page], :per_page => 12)
    render 'show_follow'
  end

  def friends
    @user = User.find(params[:id])
    if current_user == @user
      @label = "好友"
    else
      @label = "TA的好友"
    end
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
    @followed_groups = User.followed_related_groups(@user)
    render 'show_following_invitations'
  end

  def my_invitations
    @user = User.find(params[:id])
    @my_invitations = Invitation.initiated_by_user(@user)
    @my_groups = @user.mygroups
    @my_groupships = []
    @my_groups.each do |mygroup|
      @my_groupships = @my_groupships | GroupGroupship.find_all_by_applied_group_id(mygroup.id)
    end
    render 'show_my_invitations'
  end

  def friends_invitations
    @user = User.find(params[:id])
    @my_invitations = Invitation.initiated_by_user(@user)
    render 'show_my_invitations'
  end

  def active_invitations
    @user = User.find(params[:id])
    @related_groups = []
    @active_invitations = Hash.new
    @related_groups = current_user.related_groups()
    @related_groups.each do |group|
    #应征的活动
    @active_invitations[group.id] = GroupInvitationship.find_all_by_applied_group_id_and_status(group.id,"active")
    #发起的活动
    @active_invitations[group.id] = @active_invitations[group.id] | Invitation.find_all_by_initiate_group_id_and_status(group.id,"active")
    end
    render 'show_active_invitations'
  end

  def participate_activities
    @user = User.find(params[:id])
    @related_groups = []
    @participate_activities = Hash.new
    @related_groups = current_user.related_groups()
    @related_groups.each do |group|
      @tmp = GroupInvitationship.find_all_by_applied_group_id(group.id) | Invitation.find_all_by_initiate_group_id(group.id)
      @participate_activities[group.id] = @tmp
    end
    render 'show_participate_activities'
  end

  def received_invitations
    @ships = Hash.new
    @group_groupships = Hash.new
    @user = User.find(params[:id])
    @received_invitations = []
    @related_groups = @user.related_groups()
    @related_groups.each do |group|
      @received_invitations = @received_invitations | Invitation.find_all_by_initiate_group_id(group.id)
      @groupships_tmp = GroupGroupship.find_all_by_target_group_id_and_status(group.id, "pending")
      if @groupships_tmp.size > 0
        @group_groupships[group.id] = @groupships_tmp
      end
    end
    @received_invitations.each do |invitation|
      @invitation_tmp = GroupInvitationship.find_all_by_invitation_id_and_status(invitation.id,"pending")
      if @invitation_tmp.size > 0
        @ships[invitation.id] = @invitation_tmp
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
      begin
        @users << User.find(user_id)
      rescue
        next
      end
    end
    @users = @users.paginate(page: params[:page], :per_page => 12)
    render 'users/show_visitors'
  end

  def latest_followers
    @label = "最新粉丝"
    @user = User.find(params[:id])
    @follower_ships = Relationship.find_all_by_followed_id_and_status(current_user.id,"pending")
    @users = []
    @follower_ships.each do |follower_ship|
      @users << follower_ship.follower
    end
    @users = @users.paginate(page: params[:page], :per_page => 12)
    render 'show_latest_followers'
  end

  def sended_requests
    @user = User.find(params[:id])
    @related_groups = []
    @related_groups = current_user.related_groups()
    @sended_requests = Hash.new
    @related_groups.each do |group|
      @sended_request_tmp = GroupInvitationship.find_all_by_applied_group_id(group.id)
      @sended_group_request_tmp = GroupGroupship.find_all_by_applied_group_id(group.id)
      @sended_tmp = @sended_request_tmp | @sended_group_request_tmp
      if @sended_tmp.size > 0
        @sended_requests[group.id] = @sended_tmp
      end
    end
    render 'show_sended_requests'
  end

  def detect_authorization
    @user = User.find(params[:id])
    if @user == current_user
      return true
    else
      redirect_to user_path(current_user), :notice => "您无权访问该页面哦"
      return false
    end
  end

  def store_location!
    store_location
  end
end
