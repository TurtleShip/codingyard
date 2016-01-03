require 'rails_helper'

describe User do

  before(:each) do
    @user = create(:user)
  end

  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  it { should have_many(:top_coder_srm_solutions).dependent(:destroy) }
  it { should have_many(:codeforces_round_solutions).dependent(:destroy) }
  it { should have_many(:uva_solutions).dependent(:destroy) }

  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username).case_insensitive }
  it { should allow_value('abCd-_-123').for(:username) }
  it { should_not allow_value('!@#$%^&*()+').for(:username) }
  it { should validate_length_of(:username).is_at_least(3).is_at_most(20) }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should allow_values('user@example.com', 'USER@foo.COM', 'A_US-ER@foo.bar.org',
                           'first.last@foo.jp', 'alice+bob@baz.cn').for(:email) }
  it { should_not allow_values('user@example,com', 'user_at_foo.org', 'user.name@example.',
                               'foo@bar_baz.com', 'foo@bar+baz.com', 'foo@bar..com').for(:email) }
  it { should validate_length_of(:email).is_at_least(3).is_at_most(50) }

  it { should_not validate_presence_of(:firstname) }
  it { should_not validate_uniqueness_of(:firstname) }
  it { should allow_values('Wassup', 'King George III', 'Mike-Ikerson', 'foreigner12', 'O\'reily').for(:firstname) }
  it { should_not allow_values('drop-database;', 'select *', 'the bangs!!!').for(:firstname) }

  it { should_not validate_presence_of(:lastname) }
  it { should_not validate_uniqueness_of(:lastname) }
  it { should allow_values('Wassup', 'King George III', 'Mike-Ikerson', 'foreigner12', 'O\'reily').for(:lastname) }
  it { should_not allow_values('drop-database;', 'select *', 'the bangs!!!').for(:lastname) }

  it { should validate_presence_of(:password) }
  it { should validate_length_of(:password).is_at_least(6) }

  describe '#authenticated?' do

    it 'returns false when corresponding digest is nil' do
      expect { @user.authenticated?(:remember, 'random_value') }
    end
  end

end