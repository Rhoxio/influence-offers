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

end