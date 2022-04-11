class ChatroomsController < ApplicationController
  def show
    @chatrooms = Chatroom.all
    @chatroom = Chatroom.find(params[:id])
  end
end
