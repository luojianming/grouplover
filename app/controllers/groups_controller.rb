#encoding: utf-8
class GroupsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  def index
    if params[:search] != nil
      @groups = Group.search(params[:search])
    else 
      @groups = Group.all
    end
  end
=begin
  def show
  end
=end

  def create

    @member_ids = params[:member_ids]
    @labels = params[:group][:labels]
    @labels_num = @labels.size
    @member_num = @member_ids.size
    params[:group][:labels]=""
    params[:group][:group_memberships_attributes] = {}
    for i in 0..@member_num-1
      params[:group][:group_memberships_attributes][i.to_s] = {}
      params[:group][:group_memberships_attributes][i.to_s][:member_id] = @member_ids[i.to_i]
    end
    for i in 1..@labels_num-1
      if i == 1
        params[:group][:labels] += @labels[i]
      else
        params[:group][:labels] += "," + @labels[i] 
      end
    end
    @group = current_user.mygroups.build(params[:group])
     respond_to do |format|
      if @group.save
        format.html { redirect_to root_path, notice: 'Group was successfully created.' }
        format.json { render json: @profile, status: :created, location: @profile }
      else
        format.html { redirect_to new_group_path, :notice => "创建小组失败" }
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
    params[:group][:status] = @group.status
    @num = @group.group_memberships.count
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
    @group = current_user.mygroups.build
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
end
