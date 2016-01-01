FactoryGirl.define do

  factory :uva_solution do
    user
    language
    sequence(:problem_number) { |n| n }

    callback(:after_build, :before_create) do |solution|
      @uva = find_or_create(:uva)
      solution.contest = @uva
    end

  end
end
