FactoryGirl.define do

  factory :user do
    sequence(:username) { |id| "user_#{id}" }
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    email { Faker::Internet.email }
    password_digest User.digest('password')
    admin false
    activated true
    activated_at Time.zone.now

    trait :admin do
      sequence(:username) { |id| "admin_#{id}" }
      sequence(:email) { |id| "admin_#{id}@codingyard.com" }
      admin true
    end

    factory :admin_user, traits: [:admin]
  end

end
