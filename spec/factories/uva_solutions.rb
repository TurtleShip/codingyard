FactoryGirl.define do

  factory :uva_solution do
    user
    language
    sequence(:problem_number) { |n| n }

    callback(:after_build, :before_create) do |solution|
      solution.contest = find_or_create(:uva)
    end

  end
end
