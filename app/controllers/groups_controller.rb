#encoding: utf-8
require 'will_paginate/array'
class GroupsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :members_should_of_the_same_sex, :only => :create
  before_filter :cannot_have_the_same_members, :only => :create
  before_filter :member_counts_limit, :only => :create
  load_and_authorize_resource
  def index
    per_page = 100
    if params[:search] != nil
      @groups = Group.search(params[:search],:per_page => per_page)
    end
    if @groups == nil
      @groups = Group.by_group_location(params[:city]).search(:per_page => per_page) if (params[:city] && params[:city].to_s.size != 0 && params[:city] != "全国")
    else 
      @groups = @groups.by_group_location(params[:city]).search(:per_page => per_page) if (params[:city] && params[:city].to_s.size != 0 && params[:city] != "全国")
    end
    if @groups == nil
      if (params[:member_counts] && params[:member_counts].to_s.size != 0 && params[:member_counts] != "人数不限")
        @groups = Group.with_member_counts(params[:member_counts].to_i-1).search(:per_page => per_page)
      end
    else
      if (params[:member_counts] && params[:member_counts].to_s.size != 0 && params[:member_counts] != "人数不限")
        @groups = @groups.with_member_counts(params[:member_counts].to_i-1).search(:per_page => per_page)
      end
    end
    if @groups == nil
      if (params[:sex] && params[:sex].to_s.size != 0 && params[:sex] != "性别不限")
        @groups = Group.by_sex(params[:sex]).search(:per_page => per_page)
      end
    else
      if (params[:sex] && params[:sex].to_s.size != 0 && params[:sex] != "性别不限")
        @groups = @groups.by_sex(params[:sex]).search(:per_page => per_page)
      end
    end
    if @groups == nil
      @groups = Group.all.paginate(page: params[:page], :per_page => 12)
    else
      @groups = @groups.paginate(page: params[:page], :per_page => 12)
    end
  end
=begin
  def show
  end
=end

  def create
debugger
    @member_ids = params[:member_ids]
    if @member_ids == nil
      @member_ids = []
    end
    @member_num = @member_ids.size
    params[:group][:sex] = current_user.profile.sex
    params[:group][:group_memberships_attributes] = {}
    for i in 0..@member_num-1
      params[:group][:group_memberships_attributes][i.to_s] = {}
      params[:group][:group_memberships_attributes][i.to_s][:member_id] = @member_ids[i.to_i]
      params[:group][:group_memberships_attributes][i.to_s]["status"] = "pending"
    end
    debugger
    @group = current_user.mygroups.build(params[:group])
     respond_to do |format|
      if @group.save
        format.html { redirect_to groups_user_path(current_user), notice: '小组创建成功' }
        format.json { render json: @profile, status: :created, location: @profile }
      else
        format.html { render 'new'}
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @group = Group.destroy(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def update
    debugger
    @group = Group.find(params[:id])
    params[:group][:status] = @group.status
    @num = @group.members.count
    for i in  0..@num-1
      params[:group][:group_memberships_attributes][i.to_s][:status] = @group.group_memberships[i].status
    end
    if @group.update_attributes(params[:group])
      redirect_to group_path(@group), :notice => "更新成功"
    else
      redirect_to group_path(@group), :notice => "更新失败"
    end
  end

  def new
     @group = current_user.mygroups.build()
    #  @group = Group.new
=begin
     1.times {
      @group.group_memberships.build
    }
=end
  end

  def edit
    @group = Group.find(params[:id])
    render 'new'
  end
  def members_should_of_the_same_sex
    debugger
    params[:member_ids].each do |member_id|
      if User.find(member_id.to_i).profile.sex != current_user.profile.sex
        flash[:error] = "一个小组的所有成员必须是同性"
        redirect_to new_group_path
        return false
      end
    end
  end

  def cannot_have_the_same_members
    members_tmp = []
    params[:member_ids].each do |member_id|
      members_tmp << User.find(member_id.to_i)
    end
    current_user.mygroups.each do |mygroup|
      if mygroup.members == members_tmp
        flash[:notice] = "您所创建的小组已经存在了"
        redirect_to new_group_path
        return false
      end
    end
  end

  def member_counts_limit
    member_num = params[:member_ids].size + 1
    if member_num < 2 || member_num > 4
      flash[:error] = "成员数必须是2~4人哦"
      redirect_to new_group_path
      return false
    end
  end
end
