class OfferTag < ApplicationRecord
  belongs_to :tag
  belongs_to :offer
end