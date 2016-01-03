FactoryGirl.define do

  levels = %w(A B C D E)

  factory :codeforces_round_solution do
    user
    language
    sequence(:round_number) { |n| n }
    sequence(:division_number) { |n| (n%2) + 1 }
    sequence(:level) { |idx| levels[idx % 5] }

    callback(:after_build, :before_create) do |solution|
      solution.contest = find_or_create(:topcoder)
    end
  end

end
