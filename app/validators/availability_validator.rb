class AvailabilityValidator < ActiveModel::EachValidator

  def validate(record)
    # bookings = Booking.where(["desk_id =?", record.desk_id])
    arel = Booking.arel_table
    return Booking.where(arel[:start_date].lteq(record.end_date).and(arel[:end_date].gteq(record.start_date))).!exist?
  end

end

