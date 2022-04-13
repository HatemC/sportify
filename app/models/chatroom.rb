class Chatroom < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :recepient, class_name: "User"
  has_many :messages
end
