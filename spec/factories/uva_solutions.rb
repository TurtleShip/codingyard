FactoryGirl.define do

  factory :uva_solution do
    user
    language
    problem_number Faker::Number.number(5)

    before(:create) do |solution|
      @uva ||= FactoryGirl.create(:uva)
      solution.contest = @uva
    end
  end

end
