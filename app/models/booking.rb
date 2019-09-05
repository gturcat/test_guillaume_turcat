class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :desk
  validates :start_date, :end_date, presence: true, availability: true
end
