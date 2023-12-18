class OfferTargetAgeRangeValidator < ActiveModel::Validator
  def validate(offer)
    if offer.min_age && offer.max_age && offer.target_age
      
      is_in_range = (offer.min_age <= offer.target_age ) && (offer.target_age <= offer.max_age)
      return true if is_in_range

      offer.errors.add :base, 
        "Offer must have a target_age within the range of min_age and max_age:
        target_age: #{offer.target_age}
        min_age: #{offer.min_age}
        max_age: #{offer.max_age}"
    end
  end  
end