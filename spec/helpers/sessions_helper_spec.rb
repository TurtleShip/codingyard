require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SessionsHelper, type: :helper do

  let(:user) { create(:user) }

  describe '.current_user?' do

    it 'returns the current user' do
      remember(user)
      expect(current_user).to eq(user)
    end

    it 'returns nil when not logged in' do
      expect(current_user).to be_nil
    end

  end

end
