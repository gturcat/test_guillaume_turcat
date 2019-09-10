class AvailabilityValidator < ActiveModel::EachValidator

  def validate(record)
    # bookings = Booking.where(["desk_id =?", record.desk_id])
    arel = Booking.arel_table
    if (Booking.where(arel[:start_date].lteq(record.end_date).and(arel[:end_date].gteq(record.start_date))).exists?)
      record.errors.add :start_date, "overbooking"
    end
  end

end

