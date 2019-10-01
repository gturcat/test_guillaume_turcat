class Desk < ApplicationRecord
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
  has_many :bookings
  has_many :prices
  has_many :prestations, through: :prices
  accepts_nested_attributes_for :prices
end
