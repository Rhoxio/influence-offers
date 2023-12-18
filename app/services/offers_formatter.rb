class OffersFormatter < ApplicationService

  SUGGESTIONS_REQUIRED_ATTRIBUTES = [:offer, :weight, :contribution].freeze

  def self.from_base(offers)
    offers.map do |offer| 
      {
        offer: offer, 
        tags: offer.tags.sort_by(&:name), 
        show: true,
        weight: 0,
        contribution: {tags: 0, gender: 0, age: 0, claimed: 0}
      }
    end
  end

  def self.from_suggestions(offers_data)

    SUGGESTIONS_REQUIRED_ATTRIBUTES.each do |attribute|
      offers_data.each do |offer_data|
        return offers_formatter_args_error(attribute, offer_data) if !offer_data.respond_to?(attribute)  
      end
    end

    offers_data.map do |offer_data|
      {
        offer: offer_data.offer,
        tags: offer_data.offer.tags.sort_by(&:name),
        show: true,
        weight: offer_data.weight,
        contribution: offer_data.contribution,
        genders: offer_data.offer.target_genders
      }
    end
  end

  private

  def self.offers_formatter_args_error(attribute, offer_data)
    raise ArgumentError, "Required attribute #{attribute} was not present in: \n #{offer_data}"
  end

end