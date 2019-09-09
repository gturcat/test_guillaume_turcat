class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :desk
  validates :start_date, :end_date, presence: true
  validate :availability

  scope :booking_of_next_seven_day, -> { where(start_date: (Time.now.midnight)..(Time.now.midnight + 7.day)) }
  # scope :booking_of_next_seven_day, -> { select(Arel.star).where(Arel::Nodes::Between.new(:start_day, (Date.today).and(Date.today + 7.day)) )}

  # scope :previous_booking, -> { where("start_date <= ?", ) }
  scope :previous_booking, -> { select(Arel.star).where(Booking.arel_table[:start_date].lt(Time.now.midnight)) }

  private

def availability
    arel = Booking.arel_table
    unless (Booking.where(arel[:start_date].lteq(arel[:end_date]).and(arel[:end_date].gteq(arel[:start_date])))).exists?
      errors.add(:start_date, "overbooking")
    end
  end
end
