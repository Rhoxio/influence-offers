# Colors come from config/intializers/string_patches.rb

# Seed Offers
# Seed Tags
# Associate Offers with 2 Tags each

def bar
  Array.new(50, "-").join.green
end

if Rails.env.development?

  puts bar
  puts "Running seeds in Development Environment...".green
  puts bar

  puts "Creating Tags...".blue
  tag_names = ["Premium Currency", "Cash for Play", "Referral", "Free Play Time", "In-Game Reward", "App Testing"]
  tag_names.each do |tag_name|
    if !Tag.where(name: tag_name).present?
      Tag.create!(name: tag_name) 
      puts "Created Tag: #{tag_name}".blue
    else
      puts "Skipped Tag: #{tag_name}".yellow
    end
  end
  puts bar

  # I want some variance in the offers. 
  # 67% female, 88% 25+ years old according to the website.
  # I can follow these metrics fairly easily.

  # Female-Targeted, 25+
  if Offer.all.length == 0
    lucrative_female_age_range = (25..45).to_a
    upper_female_age_range = (46..65).to_a
    lower_female_age_range = (16..24).to_a

    60.times do
      target_age = lucrative_female_age_range.sample
      offer_name = (Faker::Adjective.positive + " " + Faker::Creature::Animal.name).split(" ").map{|w| w.capitalize}.join(" ")
      offer_data = {
        title: offer_name,
        description: Faker::Marketing.buzzwords,
        target_age: target_age,
        max_age: target_age + ((3..6).to_a.sample),
        min_age: target_age - ((3..6).to_a.sample)
      }
      Offer.create!(offer_data)
    end

    4.times do 
      target_age = upper_female_age_range.sample
      offer_name = (Faker::Adjective.positive + " " + Faker::Creature::Animal.name).split(" ").map{|w| w.capitalize}.join(" ")
      offer_data = {
        title: offer_name,
        description: Faker::Marketing.buzzwords,
        target_age: target_age,
        max_age: target_age + ((3..6).to_a.sample),
        min_age: target_age - ((3..6).to_a.sample)
      }
      Offer.create!(offer_data)      
    end

    3.times do 
      target_age = lower_female_age_range.sample
      offer_name = (Faker::Adjective.positive + " " + Faker::Creature::Animal.name).split(" ").map{|w| w.capitalize}.join(" ")
      offer_data = {
        title: offer_name,
        description: Faker::Marketing.buzzwords,
        target_age: target_age,
        max_age: target_age + ((3..6).to_a.sample),
        min_age: target_age - ((3..6).to_a.sample)
      }
      Offer.create!(offer_data)      
    end    

  end

end