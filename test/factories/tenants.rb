FactoryGirl.define do
  factory :tenant do
    domain { Faker::Internet.domain_name }
    sequence(:schema) {|i| "schema#{i}"}
  end
end