class FreedaysUdpateJob < ApplicationJob
  queue_as :default

  def perform

    Desk.all.each do |desk|

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

      desk.freedays = Date.current.end_of_month.day - total_days
      desk.save!
    end
  end

end

