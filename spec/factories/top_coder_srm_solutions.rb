FactoryGirl.define do

  difficulties = %w(easy medium hard)

  factory :top_coder_srm_solution do
    user
    language
    sequence(:srm_number) { |n| n }
    sequence(:division_number) { |n| (n % 2) + 1 }
    sequence(:difficulty) { |idx| difficulties[idx % 3] }

    callback(:after_build, :before_create) do |solution|
      solution.contest = find_or_create(:topcoder)
    end
  end

end
