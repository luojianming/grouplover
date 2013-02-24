#encoding: utf-8
class PrivateMessagesController < ApplicationController
  # GET /private_messages
  # GET /private_messages.json
  def index
    @private_messages = PrivateMessage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @private_messages }
    end
  end

  # GET /private_messages/1
  # GET /private_messages/1.json
  def show
    @original_private_message = PrivateMessage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @private_message }
    end
  end

  # GET /private_messages/new
  # GET /private_messages/new.json
  def new
    @private_message = PrivateMessage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @private_message }
    end
  end

  # GET /private_messages/1/edit
  def edit
    @private_message = PrivateMessage.find(params[:id])
  end

  # POST /private_messages
  # POST /private_messages.json
  def create
    @private_message = PrivateMessage.new(params[:private_message])

    respond_to do |format|
      if @private_message.save
        format.html { redirect_to my_private_messages_user_path(current_user), notice: '回复成功' }
        format.json { render json: @private_message, status: :created, location: @private_message }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @private_message.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /private_messages/1
  # PUT /private_messages/1.json
  def update
    @private_message = PrivateMessage.find(params[:id])

    respond_to do |format|
      if @private_message.update_attributes(params[:private_message])
        format.html { redirect_to @private_message, notice: 'Private message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @private_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /private_messages/1
  # DELETE /private_messages/1.json
  def destroy
    @private_message = PrivateMessage.find(params[:id])
    @private_message.destroy

    respond_to do |format|
      format.html { redirect_to private_messages_url }
      format.json { head :no_content }
    end
  end
end
