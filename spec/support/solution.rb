RSpec.shared_examples 'a solution' do

  it { should belong_to(:user) }
  it { should belong_to(:contest) }
  it { should belong_to(:language) }

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:contest_id) }
  it { should validate_presence_of(:language_id) }

end