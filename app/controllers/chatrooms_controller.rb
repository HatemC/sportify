class ChatroomsController < ApplicationController
  def show
    @chatrooms = Chatroom.all
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
    authorize @chatroom
  end

  def new
    @chatroom = Chatroom.new
    authorize @chatroom
  end

  def create
    @chatroom = Chatroom.new(chat_params)
    @chatroom.sender = current_user
    authorize @chatroom
    if @chatroom.save!
      redirect_to chatroom_path(@chatroom), notice: "new conversion was created"
    else
      render :new
    end
  end

  private

  def chat_params
    params.require(:chatroom).permit(:sender, :recepient)
  end

end
