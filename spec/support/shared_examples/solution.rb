RSpec.shared_examples 'a solution' do |solution_factory_name, solution_class|

  it { should belong_to(:user) }
  it { should belong_to(:contest) }
  it { should belong_to(:language) }

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:language_id) }

  before(:each) do
    @user = create(:user)
  end

  it 'always set to correct contest' do
    solution = create(solution_factory_name)
    solution.contest = find_or_create(:fake_contest)
    solution.save
    expect(solution.contest).to be solution_class.default_contest

    solution.contest = nil
    solution.save
    expect(solution.contest).to be solution_class.default_contest
  end

  # TODO: This feature is not actually working in prod but passing test
  # TODO: Please update me to correctly reflect the state of this feature.
  it 'updates the author\'s solutions_counter correctly' do
    expect { @solution = create(solution_factory_name, user: @user) }.to change { @user.solutions_count }.by(1)
    expect { @solution.destroy }.to change { @user.solutions_count }.by(-1)
  end

end