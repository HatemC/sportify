class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :status, presence: true
end
