class Message < ApplicationRecord
  belongs_to :Chatroom
  belongs_to :User

  validates :content, presence: true
end
