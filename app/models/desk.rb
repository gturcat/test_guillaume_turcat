class Desk < ApplicationRecord

  #geocoding
  geocoded_by :address
  after_validation :geocode,  if: ->(obj){ obj.address.present? and obj.address_changed? }

  #search
  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :name ],
    associated_against: {
      prestations: [ :id, :name ]
    },
    using: {
      tsearch: { prefix: true }
    }
  mount_uploader :photo, PhotoUploader

  #associations
  has_many :bookings
  has_many :prices
  has_many :prestations, through: :prices
  accepts_nested_attributes_for :prices,
                                allow_destroy: true


  #scope
  scope :desk_to_delete, -> (start_date, end_date){
    left_outer_joins(:bookings)
    .where(Booking.arel_table[:start_date].lteq(end_date).and(Booking.arel_table[:end_date].gteq(start_date)))
  }
  scope :desk_to_keep, ->  (start_date, end_date){  where.not(id: desk_to_delete(start_date, end_date))}

  scope :desks_with_prestations, ->(prestation1, prestation2){ left_outer_joins(:prestations).where(Prestation.arel_table[:name].in(prestation1))}


end
