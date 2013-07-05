FactoryGirl.define do

  factory :user do
    email { Faker::Internet.email }
    fullname { Faker::Name.name }
    password { 'test_password' }
    password_confirmation { 'test_password' }

    confirmed_at { 1.hour.ago }
  end

end