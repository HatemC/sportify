class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :events, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_one_attached :photo
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    geocoded_by :address
  after_validation :geocode
  def name
    first_name + " " + last_name
  end
end
