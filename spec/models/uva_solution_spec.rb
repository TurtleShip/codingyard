require 'rails_helper'
require 'support/shared_examples/solution'

RSpec.describe UvaSolution, type: :model do

  it 'has a valid factory' do
    user = create(:user)
    cpp = create(:cpp)
    solution = build(:uva_solution, user: user, language: cpp)
    expect(solution).to be_valid
  end

  it_behaves_like 'a solution'

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:contest_id) }
  it { should validate_presence_of(:language_id) }
  it { should validate_presence_of(:problem_number) }
  it { should validate_numericality_of(:problem_number).is_greater_than(0) }

  it { should validate_length_of(:original_link).is_at_most(255) }
  it { should validate_length_of(:title).is_at_most(255) }

end
