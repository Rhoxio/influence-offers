def generate_age_range
  (30..35).to_a.sample
end

FactoryBot.define do

  factory :tag do
    name {Faker::Marketing.buzzwords.first(20).split("").shuffle.join}
  end

  factory :female_gender, class: Gender do
    name {'female'}
    label {'Female'}
  end 

  factory :male_gender, class: Gender do
    name {'male'}
    label {'Male'}
  end   

  factory :new_player, class: Player do
    email {Faker::Internet.email}
    password {"password"}
    age {35}
    gender {"female"}
  end

  factory :new_offer, class: Offer do 
    title {"Test Offer"}
    description {"Test description for a test offer."} 
    target_age {35}
    min_age {30}
    max_age {40}
    after(:create) do |offer|
      offer.target_genders << [FactoryBot.create(:female_gender)]
    end    
  end

  factory :male_offer, class: Offer do 
    title {"Test Offer"}
    description {"Test description for a test offer."}
    target_age {35}
    min_age {30}
    max_age {40}
    after(:create) do |offer|
      offer.target_genders << [FactoryBot.create(:male_gender)]
    end
  end  

  # factory :random_offer, class: Offer do 
  #   title {"Test Offer"}
  #   description {"Test description for a test offer."}
  #   target_gender {["female", "male", "nonbinary", 'declined'].sample}
  #   target_age {generate_age_range}
  #   min_age {(18..34).to_a.sample}
  #   max_age {(36..60).to_a.sample}
  # end  

end