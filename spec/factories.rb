FactoryBot.define do

  factory :tag do
    name {Faker::Marketing.buzzwords.first(20)}
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

end