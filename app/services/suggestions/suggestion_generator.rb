class SuggestionGenerator < ApplicationService

  attr_reader :tag_frequencies, :relevant_offers, :claimed_offers, :offer_weights

  def initialize(player)
    @player = player
    @claimed_offers = player.offers
    @tag_frequencies = generate_tag_frequencies
    @relevant_offers = Offer.all - @claimed_offers
    @offer_weights = build_weight_structs
  end

  # As long as weight is above 0, show

  def build_weight_structs
    @relevant_offers.map do |offer| 
      weight_struct = Struct.new(:offer, :weight)    
      weight_struct.new(offer, 0)
    end
  end

  # If tag is at tally max,           +++ score
  # If tag is in between max and min, ++  score
  # if tag is at count min,           +   score

  def generate_tag_frequencies
    tallied_tags = @claimed_offers.map do |offer|
      offer.tags
    end.flatten.map(&:id).tally
  end

  def min_max_tag_frequencies
    maxes = @tag_frequencies.max_by{|k,v| v}
    mins = @tag_frequencies.min_by{|k,v| v}
    return {
      max: {
        id: maxes[0],
        count: maxes[1]
      },
      min: {
        id: mins[0],
        count: mins[1]
      }
    }
  end

  def gender_weighted?
    ['male', 'female'].include?(@player.gender)
  end

  def weigh_gender
    @offer_weights.each do |pair|
      offer = pair.offer
      if gender_weighted?
        pair.weight += 10 if offer.target_gender == @player.gender
      end
    end
  end

  def calc_age_range_weight(offer)
    # Was going to do this in ternary, but it's super hard to read that way.
    # So I just laid it out...
    age_diff = (@player.age - offer.target_age)
    side = age_diff > 0 ? :max : :min
    if side == :max
      # max 45
      # target 35
      # age 37
      inner_diff = @player.age - offer.target_age # 2
      total_range = offer.max_age - offer.target_age # 10
      seed = (inner_diff.to_f / total_range.to_f) # 0.2
    elsif side == :min
      # min 25
      # target 35
      # age 29
      inner_diff = offer.target_age - @player.age  # 6
      total_range = offer.target_age - offer.min_age # 10
      seed = (inner_diff.to_f / total_range.to_f) # 0.6
    end

    score = (1 - seed)
    weight = (score * 10).floor
    return weight
  end

  def weigh_age_range
    @offer_weights.each do |pair|
      offer = pair.offer
      if offer.target_age == @player.age
        pair.weight += 10
        next
      elsif (offer.min_age < @player.age) && (offer.max_age > @player.age)
        pair.weight += calc_age_range_weight(offer)
        next
      end

    end
  end


end