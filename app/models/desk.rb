class Desk < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  has_many :bookings
  has_many :prices
  accepts_nested_attributes_for :prices
end
