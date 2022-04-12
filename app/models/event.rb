class Event < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy

  validates :sport, :level, :date, :duration, presence: true
end
