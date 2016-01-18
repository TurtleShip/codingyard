FactoryGirl.define do

  levels = %w(A B C D E)

  factory :codeforces_round_solution do
    association :user
    association :language, factory: :cpp
    sequence(:round_number) { |n| n }
    sequence(:division_number) { |n| (n%2) + 1 }
    sequence(:level) { |idx| levels[idx % 5] }
  end

end
