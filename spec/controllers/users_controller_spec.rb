require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  # Actively creating users here using let! because if I lazily create them
  # using let, then destroy test gets broken.
  # With let, user that I want to test to be deleted only gets created when
  # a delete request gets issued, which results in disguising test results of
  # a user being created by issueing delete request.

  let!(:admin) { create(:admin_user) }
  let!(:member) { create(:user) }
  let!(:other_member) { create(:user) }

  describe '#index' do
    it 'let anyone see index' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe '#edit' do
    it 'should not allow guest' do
      get :edit, params: {id: member.id}
      expect(flash[:error]).to be_present
      expect(response).to redirect_to login_url
    end

    it 'should not allow guest wrong user' do
      log_in_as(other_member)
      get :edit, params: {id: member.id}
      expect(flash[:error]).to be_present
      expect(response).to redirect_to users_path
    end
  end

  describe '#update' do
    it 'should not allow guest guest' do
      patch :update, params: {id: member.id, user: {username: 'valid_new_name'}}
      expect(flash[:error]).to be_present
      expect(response).to redirect_to login_url
    end

    it 'should not allow guest wrong user' do
      log_in_as(other_member)
      patch :update, params: {id: member.id, user: {username: 'valid_new_name'}}
      expect(flash[:error]).to be_present
      expect(response).to redirect_to users_path
    end
  end

  describe '#destroy' do
    it 'should not allow guest guest' do
      expect { delete :destroy, params: {id: member.id} }.not_to change { User.count }
      expect(flash[:error]).to be_present
      expect(response).to redirect_to login_url
    end

    it 'should not allow member' do
      log_in_as(member)
      expect { delete :destroy, params: {id: member.id} }.not_to change { User.count }
      expect(flash[:error]).to be_present
      expect(response).to redirect_to users_path
    end
  end

  describe '#show' do
    it 'should not show a member\'s email to guest' do
      get :show, params: {id: member.id}
      expect(assigns(:user_basic_info)[:email]).to be_nil
    end

    it 'should not show a member\'s email to other member.' do
      log_in_as other_member
      get :show, params: {id: member.id}
      expect(assigns(:user_basic_info)[:email]).to be_nil
    end

    it 'should show a member\'s email to itself' do
      log_in_as member
      get :show, params: {id: member.id}
      expect(assigns(:user_basic_info)[:email]).to_not be_nil
    end

    it 'a member\'s email to admin' do
      log_in_as admin
      get :show, params: {id: member.id}
      expect(assigns(:user_basic_info)[:email]).to_not be_nil
    end

  end

end
