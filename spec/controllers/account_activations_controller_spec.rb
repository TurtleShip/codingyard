require 'rails_helper'

RSpec.describe AccountActivationsController, type: :controller do

  let(:user) { create(:user) }

  before(:each) do
    ActionMailer::Base.deliveries.clear
  end


  it 'should not send a new activation email to already activated user' do
    post :create, {email: user.email}
    expect(ActionMailer::Base.deliveries.size).to eq(0)
    expect(response).to redirect_to(login_path)
  end

  it 'should not send an activation link to non-existing user' do
    post :create, {email: 'hello@nonexistent.com'}
    expect(ActionMailer::Base.deliveries.size).to eq(0)
    expect(response).to redirect_to(new_account_activation_path)
  end


end
