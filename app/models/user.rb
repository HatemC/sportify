class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :events, dependent: :destroy
  has_many :chatrooms, foreign_key: :sender_id
  has_many :joigned_chatrooms, foreign_key: :recepient_id, class_name: 'Chatroom'
  has_many :bookings, dependent: :destroy
  has_one_attached :photo
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def name
    first_name + " " + last_name
  end
end
