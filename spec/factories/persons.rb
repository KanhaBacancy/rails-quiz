FactoryBot.define do
  factory :person do
    name { Faker::Name.name }
    phone_number { Faker::PhoneNumber.phone_number }
    email { Faker::Internet.email }
    company
  end
end