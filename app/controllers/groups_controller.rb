#encoding: utf-8
require 'will_paginate/array'
class GroupsController < ApplicationController
  before_filter :authenticate_user!
#  before_filter :members_should_of_the_same_sex, :only => :create
  before_filter :cannot_have_the_same_members, :only => :create
  before_filter :member_counts_limit, :only => :create
  before_filter :the_group_should_be_exist, :only => [:sended_posts,:create,:show,:update,:destroy,:invite_posts,:group_should_not_be_active]
#  before_filter :group_should_not_be_active, :only => :edit
  load_and_authorize_resource
  def index
    per_page = 100
    if params[:search] != nil
      @grouGs = Group.search(params[:search],:per_page => per_page)
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

  def show
    @group = Group.find(params[:id])
  end

  def create
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
    @group = current_user.mygroups.build(params[:group])
     respond_to do |format|
      if @group.save
        format.html { redirect_to groups_user_path(current_user), notice: '小组创建成功，等待激活' }
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
    @group = Group.find(params[:id])
    @num = @group.members.count
    @added_num = 0
    params[:group][:group_memberships_attributes] = {}
    if params[:member_ids] == nil
      params[:group][:status] = @group.status
    else
      @added_members_id = params[:member_ids]
      @added_num = @added_members_id.size
      for i in @num..(@num+@added_num-1)
        params[:group][:group_memberships_attributes][i.to_s] = {}
        params[:group][:group_memberships_attributes][i.to_s][:member_id] = @added_members_id[i-@num]
        params[:group][:group_memberships_attributes][i.to_s]["status"] = "pending"
      end
      params[:group][:status] = "pending"
    end
    if @group.update_attributes(params[:group])
      if @added_num > 0
        for i in 0..@num-1
          @group.members[i].tips.create(:tip_type => "add_members_tip",
                                        :content => "群组"+@group.name+"邀请了新的成员加入")
        end
      end
      redirect_to groups_user_path(current_user), :notice => "更新成功"
    else
      redirect_to groups_user_path(current_user), :notice => "更新失败"
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
  end
  def members_should_of_the_same_sex
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

  def add_members
    debugger
    @group = Group.find(params[:id])
    params[:member_ids].each do |member_id|
      member = User.find(member_id.to_i)
      GroupMembership.create(:group_id => @group.id, :member_id => member.id,
                             :status => "pending")
    end
  end

  def group_should_not_be_active
    @group = Group.find(params[:id])
    if Group.be_active?(@group) == true
      flash[:error] = "目前该组不能编辑"
      redirect_to groups_user_path
      return false
    end
  end

  def invite_posts
    @group = Group.find(params[:id])
    @group_groupships = GroupGroupship.find_all_by_target_group_id_and_status(@group.id, "pending")
    render 'show_invite_posts'
  end

  def sended_posts
    @group = Group.find(params[:id])
    @group_invitationships = GroupInvitationship.find_all_by_applied_group_id_and_status(@group.id, "pending")
    @group_groupships = GroupGroupship.find_all_by_applied_group_id_and_status(@group.id,"pending")
    render 'show_sended_posts'
  end


  def the_group_should_be_exist
    begin
      @group = Group.find(params[:id])
    rescue
      flash[:error] = "您访问的页面不存在"
      redirect_to user_path(current_user)
      return false
    end
  end
end
