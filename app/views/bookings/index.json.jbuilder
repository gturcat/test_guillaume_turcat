# @bookings = Booking.where(desk_id: params[:desk_id]) if params[:desk_id].present?
@bookings = Booking.select(Arel.star).where(Booking.arel_table[:desk_id].eq(params[:desk_id])) if params[:desk_id].present?

json.array!(@bookings) do |booking|
    json.extract! booking, :id, :user
    json.start booking.start_date
    json.end (booking.end_date + 1)
    json.color booking.desk.color
    json.url booking_url(booking, format: :html)
end
