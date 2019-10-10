class Price < ApplicationRecord
  belongs_to :desk
  monetize :detail_price_cents
  has_many :prestations, dependent: :destroy
  accepts_nested_attributes_for :prestations,
                                allow_destroy: true,
                                reject_if: ->(attrs) { attrs['name'].blank? || attrs['detail_price_cents'].blank? }
end
