require 'rails_helper'

RSpec.describe Language, type: :model do

  it { should have_many(:codeforces_round_solutions) }
  it { should have_many(:top_coder_srm_solutions) }
  it { should have_many(:uva_solutions) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:extension) }
  it { should validate_presence_of(:ace_mode) }

  describe '.get_all_extensions_concat' do
    it 'returns comma separated extension name' do
      create(:java)
      create(:cpp)
      create(:c)
      expect(Language.get_all_extensions_concat).to eq('.java,.cpp,.c')
    end
  end

end
