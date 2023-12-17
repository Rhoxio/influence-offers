class SuggestionGenerator < ApplicationService

  attr_reader :offer_weights

  alias_method :suggestions, :offer_weights

  def initialize(player)
    @player = player
    @claimed_offers = player.offers.includes(:tags)
    @tag_frequencies = generate_tag_frequencies
    @relevant_offers = Offer.all.preload(:tags) - @claimed_offers
    @offer_weights = build_weight_structs

    generate_weights
  end

  private

  # SETUP & TOTAL CLAIMED OFFERS
  def build_weight_structs
    @relevant_offers.map do |offer| 
      weight_struct = Struct.new(:offer, :weight, :contribution) 
      # Adding in the total_claimed as the baseline
      # weight, as it's a pretty actionable metric 
      # overall and provides good baseline variance.
      weight_struct.new(offer, offer.total_claimed, {
        tags: 0, 
        gender: 0, 
        age: 0, 
        claimed: offer.total_claimed
      })
    end
  end

  # GENERATION
  def generate_weights
    @offer_weights.each do |weight_data|
      weigh_tag(weight_data)
      weigh_gender(weight_data)
      weigh_age_range(weight_data)
    end
    @offer_weights = @offer_weights.sort_by do |weight_data|
      -weight_data.weight
    end
  end

  # TAGS
  def generate_tag_frequencies
    tallied_tags = @claimed_offers.map do |offer|
      offer.tags
    end.flatten.map(&:id).tally
  end

  def weigh_tag(weight_data)
    offer = weight_data.offer
    offer.tags.each do |tag|
      if @tag_frequencies.key?(tag.id)
        total_weight = ((@tag_frequencies[tag.id] / offer.tags.length) * 0.5).round
        weight_data.contribution[:tags] += total_weight
        weight_data.weight += total_weight
      end
    end
  end

  # GENDER
  def gender_weighted?
    ['male', 'female'].include?(@player.gender)
  end

  def weigh_gender(weight_data)
    offer = weight_data.offer
    if gender_weighted?
      (weight_data.weight += 10 && weight_data.contribution[:gender] += 10) if offer.target_gender == @player.gender
    end
  end

  # AGE
  def calc_age_range_weight(offer)
    # Can probably do this with .abs, but this solution
    # is how I whiteboarded it and works well.
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

    score = (1 - seed) # grabs inverse diff, max: .8, min: .4
    weight = (score * 10).floor # makes it into a whole number < 10
    return weight
  end

  def weigh_age_range(weight_data)
    offer = weight_data.offer
    if offer.target_age == @player.age
      weight_data.contribution[:age] += 10
      weight_data.weight += 10
      return
    elsif (offer.min_age < @player.age) && (offer.max_age > @player.age)
      total_weight = calc_age_range_weight(offer)
      weight_data.contribution[:age] += total_weight
      weight_data.weight += total_weight
      return 
    end
  end


end