require 'rails_helper'

describe User do

  before(:each) do
    @user = create(:user)
    @cpp = create(:cpp)
  end

  it 'destroys all its dependent uva solutions' do
    num_uva_solutions = 10
    num_uva_solutions.times { create(:uva_solution, user: @user, language: @cpp) }
    expect { @user.destroy }.to change { UvaSolution.count }.by(-num_uva_solutions)
  end

  it 'destroys all its dependent TopCoder SRM solutions' do
    num_topcoder_srm_solutions = 10
    num_topcoder_srm_solutions.times { create(:top_coder_srm_solution, user: @user, language: @cpp) }
    expect { @user.destroy }.to change { TopCoderSrmSolution.count }.by(-num_topcoder_srm_solutions)
  end

  it 'destroys all its dependent Codeforces solutions' do
    num_codeforces_solutions = 10
    num_codeforces_solutions.times { create(:codeforces_round_solution, user: @user, language: @cpp) }
    expect { @user.destroy }.to change { CodeforcesRoundSolution.count }.by(-num_codeforces_solutions)
  end

  describe '#authenticated?' do

    it 'returns false when corresponding digest is nil' do
      expect{ @user.authenticated?(:remember, 'random_value')}
    end
  end

end