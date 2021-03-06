class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :user_can_delete_message, only: [:destroy]
  include FiltrationUsers

  # GET /messages
  # GET /messages.json
  def index
    @messages = @conference.messages.order("created_at DESC").page params[:page]
    @message = Message.new
    gon.user_id = current_user.id
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    #message_params = params.require(:message).permit(:conference_id, :text)
    message_params = params.require(:message).permit(:conference_id, :text)
    @message = Message.new(message_params)
    @conference = @message.conference
    @message.user_id = current_user.id
    @message.save
    ActionCable.server.broadcast "conference_#{@conference.id}",
      message: params[:message][:text],
      username: current_user.email,
      id: @message.id,
      user_id: current_user.id
    head :ok
    #respond_to do |format|
      #if @message.save
        #format.html { redirect_to conference_messages_path @message.conference_id, notice: 'Message was successfully sended.' }
        #format.json { render :show, status: :created, location: @message }
      #else
        #format.html { render :new }
        #format.json { render json: @message.errors, status: :unprocessable_entity }
      #end
    #end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @conference = @message.conference
    #убрать этот костыль
    if not @conference.users.include?(current_user)
      redirect_to error_index_path, notice: 'access denied'
    end
    @message.destroy
    respond_to do |format|
      format.html { redirect_to conference_messages_path @conference.id, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:text)
    end

    def user_can_delete_message
      if @message.user != current_user
        redirect_to error_index_path, notice: 'you can not delete this message'
      end
    end
end
