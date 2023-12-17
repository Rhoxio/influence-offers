def generate_age_range
  (30..35).to_a.sample
end

FactoryBot.define do

  factory :tag do
    name {Faker::Marketing.buzzwords.first(20).split("").shuffle.join}
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
    target_gender {"female"}
    target_age {35}
    min_age {30}
    max_age {40}
  end

  factory :male_offer, class: Offer do 
    title {"Test Offer"}
    description {"Test description for a test offer."}
    target_gender {"male"}
    target_age {35}
    min_age {30}
    max_age {40}
  end  

  factory :random_offer, class: Offer do 
    title {"Test Offer"}
    description {"Test description for a test offer."}
    target_gender {["female", "male", "nonbinary", 'declined'].sample}
    target_age {generate_age_range}
    min_age {(18..34).to_a.sample}
    max_age {(36..60).to_a.sample}
  end  

end