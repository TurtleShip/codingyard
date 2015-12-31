FactoryGirl.define do

  factory :top_coder_srm_solution do
    user
    language
    srm_number Faker::Number.number(3)
    division_number Faker::Number.between(1, 2)
    difficulty %w(easy medium hard)[Faker::Number.between(0, 2)]

    before(:create) do |solution|
      @topcoder ||= FactoryGirl.create(:topcoder)
      solution.contest = @topcoder
    end
  end

end
