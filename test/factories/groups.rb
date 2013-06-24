FactoryGirl.define do

  factory :group do
    name { Faker::Lorem.words(1).join }
  end

end