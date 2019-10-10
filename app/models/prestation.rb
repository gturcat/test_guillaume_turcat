class Prestation < ApplicationRecord
  # associations
  belongs_to :price, optional: true
  monetize :detail_price_cents

  # scope
  scope :list_prestations, -> { pluck(:name) }

end
