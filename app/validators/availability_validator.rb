class AvailabilityValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    # bookings = Booking.where(["desk_id =?", record.desk_id])
    bookings = Booking.select(Arel.star).where(Booking.arel_table[:desk_id].eq(record.desk_id))
    date_ranges = bookings.map { |b| b.start_date..b.end_date }

    date_ranges.each do |range|
      if range.include? value
        record.errors.add(attribute, "not available")
      end
    end
  end
end
