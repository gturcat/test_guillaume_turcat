class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :desk
  validates :start_date, :end_date, presence: true, availability: true

  scope :booking_of_next_seven_day, -> { where(start_date: (Time.now.midnight)..(Time.now.midnight + 7.day)) }
  scope :previous_booking, -> { where("start_date <= ?", Time.now.midnight) }
end
