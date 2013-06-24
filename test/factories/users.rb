FactoryGirl.define do

  factory :user do
    email { Faker::Internet.email }
    fullname { Faker::Name.name }
  end

end