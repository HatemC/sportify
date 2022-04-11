class Chatroom < ApplicationRecord
  belongs_to :User
  has_many :users
  has_many :messages
end
