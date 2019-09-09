@bookings = @bookings.where(user: current_user)


json.array!(@bookings) do |booking|
    json.extract! booking, :id, :user
    json.start booking.start_date
    json.end (booking.end_date + 1)
    json.color booking.desk.color
    json.title booking.user.email unless params[:desk_id].present?
    json.url booking_url(booking, format: :html)

end
