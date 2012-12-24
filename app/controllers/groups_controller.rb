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
  end

  def new
    @group = current_user.mygroups.build
    3.times {
      @group.group_memberships.build
    }
  end

  def edit
  end
end
