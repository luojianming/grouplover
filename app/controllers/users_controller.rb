#encoding: utf-8
require 'will_paginate/array'
class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
  end

  def show
    begin
      @user = User.find(params[:id])
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
    @received_invitations = []
    @my_invitations.each do |my_invitation|
      my_invitation.group_invitationships.each do |ship|
        @received_invitations << ship.applied_group.myinvitations.build(
          :location => ship.invitation.location,
          :time => ship.invitation.time,
          :style => ship.applied_group.labels,
          :image_url => ship.applied_group.image_url,
          :activity => ship.invitation.activity,
          :description => ship.description)
      end
    end
    render 'show_received_invitation'
  end

  def albums
    @user = User.find(params[:id])
    @albums = @user.albums
    render 'show_album'
  end
end
