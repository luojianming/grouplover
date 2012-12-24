#encoding: utf-8
class GroupsController < ApplicationController
  load_and_authorize_resource
  def index
  end

  def show
  end

  def create
=begin
    @group = current_user.mygroups.build({:name => params[:group][:name], :sex => params[:group][:sex],
                                          :member_counts => params[:group][:member_counts],
                                          :description => params[:group][:description],
                                          :labels => params[:group][:labels],
                                          :location => params[:group][:location]})

=end


    @group = current_user.mygroups.build(params[:group])
     respond_to do |format|
      if @group.save
        format.html { redirect_to root_path, notice: 'Group was successfully created.' }
        format.json { render json: @profile, status: :created, location: @profile }
      else
        format.html { render action: "new" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
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
     3.times {
      @group.group_memberships.build
    }
  end

  def edit
    @group = Group.find(params[:id])
    render 'new'
  end
end
