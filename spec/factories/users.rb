FactoryGirl.define do

  num_admin = 0

  factory :user do
    username { "#{Faker::Internet.user_name(specifier=nil, separators = %w(-_))[0..10]}_#{id}" }
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    email { Faker::Internet.email }
    password_digest User.digest('password')
    admin false
    activated true
    activated_at Time.zone.now

    trait :admin do
      username "admin_#{num_admin += 1}"
      email "admin_#{num_admin}@codingyard.com"
      admin true
    end

    factory :admin_user, traits: [:admin]
  end

end
