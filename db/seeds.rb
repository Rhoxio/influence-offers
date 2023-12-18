# Colors come from config/intializers/string_patches.rb

def bar
  Array.new(50, "-").join.green
end

def random_tags(count)
  return Tag.all.shuffle.take(count) if Tag.all.count > 0
  return []
end

def random_description
  [
    "Dive into the world of exclusive perks! Earn Premium Currency by completing exciting challenges and quests. Use your newfound wealth to unlock rare items, customize your gameplay, and dominate the leaderboards. It's time to elevate your gaming experience with the ultimate Premium Currency Extravaganza!",
    "Your skills deserve recognition! Get ready to earn Cash for Play by showcasing your gaming prowess. Whether it's achieving high scores, completing difficult levels, or outsmarting opponents, each triumph brings you closer to cold, hard cash rewards. Turn your gameplay into a rewarding adventure with Cash for Play Bonanza!",
    "Calling all gaming enthusiasts! Invite your friends to join the gaming revolution and claim Referral Rewards together. Unlock bonus features, exclusive content, and epic loot by expanding your gaming circle. The more friends you refer, the greater the rewards for everyone. Embark on the Referral Rewards Revolution today!",
    "Enjoy the freedom to play without limits! Immerse yourself in the Free Play Time Fiesta, where your dedication to the game is rewarded with extra playtime. Engage in thrilling quests, conquer challenges, and extend your gameplay hours. Embrace the joy of gaming with the Free Play Time Fiesta!",
    "Unleash the potential of your gaming journey! Conquer in-game challenges and bask in the glory of the In-Game Reward Extravaganza. Collect exclusive items, power-ups, and boosts that amplify your gameplay. Your victories pave the way for unparalleled in-game riches. Join the In-Game Reward Extravaganza and let the spoils of victory be yours!",
    "Be a pioneer in the gaming evolution! Embark on an exciting App Testing Adventure where you get an exclusive sneak peek into upcoming features and content. Test new mechanics, provide feedback, and shape the future of the game. As a tester, you're not just playing — you're influencing the gaming landscape. Start your App Testing Adventure now!"
  ].sample
end

def generate_offer(age_range, gender)
  gender = [gender].flatten
  target_age = age_range.sample
  offer_name = (Faker::Adjective.positive + " " + Faker::Creature::Animal.name).split(" ").map(&:capitalize).join(" ")
  offer_data = {
    title: offer_name,
    description: random_description,
    target_age: target_age,
    target_genders: gender,
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
  tag_names = ["Currency", "Cash", "Referral", "Play Time", "Limited", "Testing"]
  tag_names.each do |tag_name|
    if !Tag.where(name: tag_name).present?
      Tag.create!(name: tag_name) 
      puts "Created Tag: #{tag_name}".blue
    else
      puts "Skipped Tag: #{tag_name}".yellow
    end
  end
  puts bar

  
  if Gender.all.count == 0
    puts "Creating Genders...".blue
    gender_sets = Gender::GENDERS.zip(Gender::LABELS)
    gender_sets.each do |set|
      Gender.create!(name: set[0], label: set[1])
      puts "Created Gender: #{set[1]}".blue
    end
  else
    puts "Skipping Genders".yellow
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

    female = Gender.find_by(name: 'female')
    male = Gender.find_by(name: 'male')
    nonbinary = Gender.find_by(name: 'nonbinary')
    declined = Gender.find_by(name: 'declined')

    # Females
    # 60 Lucrative, 4 Over, 3 under - Gives close to an 88% ratio.
    # 60 + 4 + 3 = 67, -33
    60.times do
      generate_offer(lucrative_female_age_range, female)
    end

    4.times do 
      generate_offer(upper_female_age_range, female)     
    end

    3.times do 
      generate_offer(lower_female_age_range, female)     
    end    

    # Males
    # 67+8 = 75, -25
    8.times do 
      generate_offer(random_distribution, male)
    end

    # Males & Females
    # 75+10 =85, -15
    10.times do 
      generate_offer(random_distribution, [male, female])
    end

    # Non-Binary
    # 85+7 = 92, -8
    7.times do 
      generate_offer(random_distribution, nonbinary)
    end

    # Declined
    # 92+8 = 100, 0
    8.times do 
      generate_offer(random_distribution, declined)
    end
  end

  puts bar

end