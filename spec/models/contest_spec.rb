require 'rails_helper'

RSpec.describe Contest, type: :model do

  before(:each) do
    # Need to create one for validate_uniqueness_of.
    # It tests by trying to create a new record with the same attribute
    # of a record that already exists in database.
    @contest = create(:uva)
  end

  it { should have_many(:top_coder_srm_solutions).dependent(:destroy) }
  it { should have_many(:codeforces_round_solutions).dependent(:destroy) }
  it { should have_many(:uva_solutions).dependent(:destroy) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).case_insensitive }
  it { should validate_length_of(:name).is_at_least(1).is_at_most(50) }

  it { should_not validate_presence_of(:url) }
  it { should_not validate_uniqueness_of(:url) }

  it { should_not validate_presence_of(:description) }

  it 'should allow valid url' do
    valid_urls = ['http://www.solve.org', 'https://www.chllaenge.io/tc', 'https://uhunt.felix-halim.net']
    valid_urls.each do |valid_url|
      should allow_value(valid_url).for(:url)
    end
  end

  it 'should not allow invalid url' do
    invalid_urls = ['yolo.com, http://internal', 'localhost:8080']
    invalid_urls.each do |invalid_url|
      should_not allow_value(invalid_url).for(:url)
    end
  end

end
