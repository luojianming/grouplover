#encoding: utf-8
class AlbumsController < ApplicationController
  # GET /albums
  # GET /albums.json
  before_filter :authenticate_user!
  authorize_resource
=begin
  def index
    @albums = Album.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @albums }
    end
  end
=end

  # GET /albums/1
  # GET /albums/1.json
  def show
    @album = Album.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @album }
    end
  end

  # GET /albums/new
  # GET /albums/new.json
  def new
    @album = Album.new
    authorize! :new, @album, :message => "对不起，您没有权限创建相册哦"

    respond_to do  |format|
      format.html # new.html.erb
      format.json { render json: @album }
    end
  end

  # GET /albums/1/edit
  def edit
    @album = Album.find(params[:id])
    authorize! :edit, @album, :message => "对不起，您没有权限修改他人的相册哦"
  end

  # POST /albums
  # POST /albums.json
  def create
    @album = current_user.albums.build(params[:album])
    authorize! :edit, @album, :message => "对不起，您没有权限创建相册哦"
    respond_to do |format|
      if @album.save
        format.html { redirect_to @album, notice: 'Album was successfully created.' }
        format.json { render json: @album, status: :created, location: @album }
      else
        format.html { render action: "new" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /albums/1
  # PUT /albums/1.json
  def update
    @album = Album.find(params[:id])
    authorize! :update, @album, :message => "对不起，您没有权限修改他人的相册哦"

    respond_to do |format|
      if @album.update_attributes(params[:album])
        format.html { redirect_to @album, notice: 'Album was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album = Album.find(params[:id])
    authorize! :destroy, @album, :message => "对不起，您没有权限删除他人的相册哦"
    @album = Album.destroy(params[:id])

    respond_to do |format|
      format.html { redirect_to albums_url }
      format.json { head :no_content }
      format.js
    end
  end
end
