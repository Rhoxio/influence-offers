class ClaimedOffer < ApplicationRecord
  belongs_to :player
  belongs_to :offer
end