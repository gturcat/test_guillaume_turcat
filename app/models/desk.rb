class Desk < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  has_many :bookings
end
