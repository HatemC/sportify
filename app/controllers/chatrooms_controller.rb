class ChatroomsController < ApplicationController
  def show
    # @user = User.new
    @chatrooms = Chatroom.all
    @chatroom = Chatroom.find(params[:id])
    @chatroom2 = Chatroom.new
    @message = Message.new
    authorize @chatroom
  end

  def new
    @chatroom = Chatroom.new
    authorize @chatroom
  end

  def create
    chatroom_check = Chatroom.where(sender: User.find(params[:chatroom][:recepient_id]), recepient: current_user).or(Chatroom.where(sender: current_user, recepient: User.find(params[:chatroom][:recepient_id])))
    @chatroom = Chatroom.new(chat_params)
    authorize @chatroom
    if chatroom_check.empty?
      @chatroom.sender = current_user
      if @chatroom.save!
        redirect_to chatroom_path(@chatroom), notice: "new conversion was created"
      else
        render :new
      end
    else
      redirect_to chatroom_path(chatroom_check.ids)
    end
  end

  private

  def chat_params
    params.require(:chatroom).permit(:recepient_id)
  end

end
