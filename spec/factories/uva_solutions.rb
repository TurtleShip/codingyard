FactoryGirl.define do

  before(:all) do
    find_or_create(:uva)
  end
  factory :uva_solution do
    user
    language
    sequence(:problem_number) { |n| n }

  end
end
