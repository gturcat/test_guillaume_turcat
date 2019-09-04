Booking.select(Arel.star).where(Booking.arel_table[:desk_id].eq(:params)) if params[:desk_id].present?

json.array!(@bookings) do |booking|
    json.extract! booking, :id, :user, :desk
    json.start booking.start_date
    json.end booking.end_date
    json.url booking_url(booking, format: :html)
end
