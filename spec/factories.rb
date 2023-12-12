FactoryBot.define do

  factory :new_player, class: Player do
    email {"test@testers.com"}
    password {"password"}
    age {35}
    gender {"female"}
  end

end