FactoryGirl.define do

  factory :codeforces_round_solution do
    user
    language
    round_number Faker::Number.number(3)
    division_number Faker::Number.between(1, 2)
    level %w(A B C D E)[Faker::Number.between(0, 4)]

    before(:create) do |solution|
      @codeforces ||= FactoryGirl.create(:topcoder)
      solution.contest = @codeforces
    end
  end

end
