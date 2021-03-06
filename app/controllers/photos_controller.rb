# encoding: utf-8
require 'mime/types'
class PhotosController < ApplicationController
  before_filter :authenticate_user!
  # GET /photos
  # GET /photos.json
  authorize_resource
=begin
  def index
    @photos = Photo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @photos }
    end
  end
=end

  # GET /photos/1
  # GET /photos/1.json
  def show
    begin
      @photo = Photo.find(params[:id])
    rescue
      flash[:error] = "您访问的页面不存在"
      redirect_to user_path(current_user)
      return false
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @photo }
    end
  end
=begin
  # GET /photos/new
  # GET /photos/new.json
  def new
    @photo = Photo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @photo }
    end
  end
=end
=begin
  # GET /photos/1/edit
  def edit
    @photo = Photo.find(params[:id])
  end
=end

  # POST /photos
  # POST /photos.json
  def create
    @album = Album.find(params[:album_id].to_i)
    params[:image].content_type = MIME::Types.type_for(params[:image].original_filename)[0].to_s
=begin
    if @album.photos_count == nil
      params[:photo][:number] = 0
    else
      params[:photo][:number] = @album.photos_count
    end
=end
    @photo = @album.photos.build(:image => params[:image])
    authorize! :create, @photo, :message => "对不起，您没有权限上传照片哦"
    if @photo.save
      user = @photo.album.user
      latest_similar_feed = Feed.find_by_user_id_and_feedable_type(user.id, "Photo")
      if latest_similar_feed == nil || (Time.now - latest_similar_feed.created_at > 3600)
        feed = user.feeds.build(:feedable_type => "Photo",
                                :feedable_id => @photo.id)
        feed.save
      end
    end
=begin
    respond_to do |format |
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render json: @photo, status: :created, location: @photo }
      else
        format.html { render action: "new" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
=end
  end

  # PUT /photos/1
  # PUT /photos/1.json
  def update
    @photo = Photo.find(params[:id])
    authorize! :update, @photo, :message => "对不起，您没有权限修改照片属性哦"

    respond_to do |format|
      if @photo .update_attributes(params[:photo])
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo = Photo.find(params[:id])
    authorize! :destroy, @photo, :message => "对不起，您没有权限删除照片哦"
    @album = @photo.album
=begin 
    @num = @photo.number
    for i in (@num+1)..(@album.photos_count-1)
      @album.photos[i].update_attributes(:number => @album.photos[i].number-1)
    end
=end
    @photo = Photo.destroy(params[:id])
    respond_to do |format|
      format.html { redirect_to album_path(@photo.album) }
      format.js
    end
  end
end
