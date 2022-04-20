class ConversationsController < ApplicationController
  def conversations
    @chatroom2 = Chatroom.new
  end
end
