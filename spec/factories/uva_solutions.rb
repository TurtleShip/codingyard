FactoryGirl.define do

  factory :uva_solution do
    association :user
    association :language, factory: :cpp
    sequence(:problem_number) { |n| n }
  end

end
