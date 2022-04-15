class Event < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy

  geocoded_by :address
  validates :sport, :level, :date, :duration, presence: true
end
