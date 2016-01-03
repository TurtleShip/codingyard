require 'rails_helper'
require 'support/shared_examples/solution'

RSpec.describe TopCoderSrmSolution, type: :model do

  before(:each) do
    user = create(:user)
    cpp = create(:cpp)
    @solution = build(:top_coder_srm_solution, user: user, language: cpp)
  end

  it 'has a valid factory' do
    expect(@solution).to be_valid
  end

  it_behaves_like 'a solution', :top_coder_srm_solution

  it { should belong_to(:user) }
  it { should belong_to(:contest) }
  it { should belong_to(:language) }

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:contest_id) }
  it { should validate_presence_of(:language_id) }

  it { should validate_presence_of(:srm_number) }
  it { should validate_numericality_of(:srm_number).is_greater_than(0) }

  it { should validate_presence_of(:division_number) }
  it { should validate_inclusion_of(:division_number).in_range(1..2) }

  it { should validate_presence_of(:difficulty) }
  it { should validate_inclusion_of(:difficulty).in_array(%w(easy medium hard)) }

  it { should_not validate_presence_of(:original_link) }
  it { should validate_length_of(:original_link).is_at_most(255) }

  it 'should downcase difficulty before validation' do
    valid_difficulties = %w(EaSy eAsY EASY easy EasY eaSY)
    valid_difficulties.each do |difficulty|
      @solution.difficulty = difficulty
      expect(@solution).to be_valid
    end
  end
end
