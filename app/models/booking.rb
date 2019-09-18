class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :desk
  validates :start_date, :end_date, presence: true #tested
  validate :availability

  scope :booking_of_next_seven_day, -> { where(start_date: (Time.now.midnight)..(Time.now.midnight + 7.day)) }
  # scope :booking_of_next_seven_day, -> { select(Arel.star).where(Arel::Nodes::Between.new(:start_day, (Date.today).and(Date.today + 7.day)) )}

  # scope :previous_booking, -> { where("start_date <= ?", ) }
  scope :previous_booking, -> { select(Arel.star).where(Booking.arel_table[:start_date].lt(Time.now.midnight)) }

  # scope tous les bookings inclus dans le mois en cours
  scope :bookings_of_the_month, -> {
    where(start_date: (Date.current.beginning_of_month)..(Date.current.end_of_month) )
  }

  scope :bookings_start_the_month_before, -> {
    select(Arel.star).where(
  Booking.arel_table[:start_date].lt(Date.current.beginning_of_month).and(Booking.arel_table[:end_date].gt(Date.current.beginning_of_month))
)
  }

  scope :bookings_ended_the_month_after, ->{
    select(Arel.star).where(
  Booking.arel_table[:start_date].gt(Date.current.end_of_month).and(Booking.arel_table[:end_date].lt(Date.current.end_of_month))
)
  }

  before_save :calculate_freedays_to_concerned_desk


  private

  def availability #tested but not correct
    arel = Booking.arel_table
    if Booking.count >= 1
      if !Booking.where(arel[:start_date].lteq(arel[:end_date]).and(arel[:end_date].gteq(arel[:start_date]))).exists?
        errors.add(:start_date, "overbooking")
      end
    end
  end

  def calculate_freedays_to_concerned_desk #tested
    desk = self.desk
    total_days = 0

    bookings_of_the_month = Booking.bookings_of_the_month.where(desk: desk)
    bookings_of_the_month.each do |booking|
      total_days += (booking.end_date - booking.start_date).to_i + 1
    end
    bookings_start_the_month_before = Booking.bookings_start_the_month_before.where(desk: desk)
    bookings_start_the_month_before.each do |booking|
      total_days += (booking.end_date - Date.current.beginning_of_month).to_i
    end

    bookings_ended_the_month_after = Booking.bookings_ended_the_month_after.where(desk: desk)
    bookings_ended_the_month_after.each do |booking|
      total_days += (Date.current.end_of_month - booking.start_date).to_i
    end
    desk.freedays = Date.current.end_of_month.day - total_days - ((self.end_date - self.start_date).to_i + 1)
    desk.save!
    FreedaysUdpateJob.perform_later
  end


end
