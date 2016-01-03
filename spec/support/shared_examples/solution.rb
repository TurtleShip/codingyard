RSpec.shared_examples 'a solution' do |solution_factory_name|

  it { should belong_to(:user) }
  it { should belong_to(:contest) }
  it { should belong_to(:language) }

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:contest_id) }
  it { should validate_presence_of(:language_id) }

  it 'updates the author\'s solutions_counter correctly' do
    user = create(:user)
    cpp = find_or_create(:cpp)

    expect { @solution = create(solution_factory_name, user: user, language: cpp) }.to change { user.solutions_count }.by(1)
    expect { @solution.destroy }.to change { user.solutions_count }.by(-1)
  end

end