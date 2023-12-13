# Colors come from config/intializers/string_patches.rb

def bar
  Array.new(50, "-").join.green
end

def random_tags(count)
  return Tag.all.shuffle.take(count) if Tag.all.count > 0
  return []
end

def generate_offer(age_range, gender)
  target_age = age_range.sample
  offer_name = (Faker::Adjective.positive + " " + Faker::Creature::Animal.name).split(" ").map(&:capitalize).join(" ")
  offer_data = {
    title: offer_name,
    description: Faker::Marketing.buzzwords,
    target_age: target_age,
    target_gender: gender,
    max_age: target_age + ((3..6).to_a.sample),
    min_age: target_age - ((3..6).to_a.sample)
  }
  offer = Offer.create!(offer_data)
  offer.tags << random_tags(3)    
  puts "Generated Offer: #{offer.title}".blue
end

if Rails.env.development?

  puts bar
  puts "Running seeds in #{Rails.env}".green
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
  offer_count = Offer.all.length

  puts "Skipping Offer Generation. #{offer_count} Offers already exist.".yellow if offer_count > 0

  if offer_count == 0
    puts "Generating Offers...".blue
    lucrative_female_age_range = (25..45).to_a
    upper_female_age_range = (46..65).to_a
    lower_female_age_range = (16..24).to_a

    random_distribution = (16..65).to_a

    # Females
    # 60 Lucrative, 4 Over, 3 under - Gives close to an 88% ratio.
    # 60 + 4 + 3 = 67, -33
    60.times do
      generate_offer(lucrative_female_age_range, "female")
    end

    4.times do 
      generate_offer(upper_female_age_range, "female")     
    end

    3.times do 
      generate_offer(lower_female_age_range, "female")     
    end    

    # Males
    # 67+18 = 85, -15
    18.times do 
      generate_offer(random_distribution, "male")
    end

    # Non-Binary
    # 85+7 = 92, -8
    7.times do 
      generate_offer(random_distribution, "nonbinary")
    end

    # Declined
    # 92+8 = 100, 0
    8.times do 
      generate_offer(random_distribution, "declined")
    end
  end

  puts bar

end