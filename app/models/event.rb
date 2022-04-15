class Event < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_one_attached :photo
  geocoded_by :address

  validates :sport, :level, :date, :duration, presence: true
end
