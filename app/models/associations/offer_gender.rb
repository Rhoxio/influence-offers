class OfferGender < ApplicationRecord
  belongs_to :gender
  belongs_to :offer
end