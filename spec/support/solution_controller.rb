RSpec.shared_examples 'SolutionController' do |solution_factory_name, index_path|

  let(:admin) { create(:admin_user) }
  let(:member) { create(:user) }
  let(:other_member) { create(:user) }
  let(:cpp) { find_or_create(:cpp) }
  let(:solution) { create(solution_factory_name, user: member, language: cpp) }

  describe '#create' do

    it 'should not let a guest to upload solution' do
      get :new
      expect(response).to redirect_to(login_path)
      expect(flash[:danger]).not_to be_nil
    end

    it 'should let a member upload solution' do
      log_in_as(member)
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'should let an admin upload solution' do
      log_in_as(admin)
      get :new
      expect(response).to have_http_status(:success)
    end
  end


  describe '#delete' do

    it 'should not let a guest delete solution' do
      delete :destroy, id: solution.id
      expect(response).to redirect_to send(index_path)
      expect(flash[:danger]).not_to be_nil
    end

    it 'should not let user delete other user\'s solution' do
      log_in_as(other_member)
      delete :destroy, id: solution.id
      expect(response).to redirect_to send(index_path)
      expect(flash[:danger]).not_to be_nil
    end

    it 'should let the author delete its solution' do
      log_in_as(member)
      delete :destroy, id: solution.id
      expect(response).to redirect_to send(index_path)
      expect(flash[:success]).not_to be_nil
    end

    it 'should let the admin delete a member\'s solution' do
      log_in_as(admin)
      delete :destroy, id: solution.id
      expect(response).to redirect_to send(index_path)
      expect(flash[:success]).not_to be_nil
    end
  end


  describe '#edit' do

    it 'should not let a guest edit solution' do
      get :edit, id: solution.id
      expect(response).to redirect_to send(index_path)
      expect(flash[:danger]).not_to be_nil
    end

    it 'should not let user edit other user\'s solution' do
      log_in_as(other_member)
      get :edit, id: solution.id
      expect(response).to redirect_to send(index_path)
      expect(flash[:danger]).not_to be_nil
    end

    it 'should let the author its solution' do
      log_in_as(member)
      get :edit, id: solution.id
      expect(response).to have_http_status(:success)
    end

    it 'should let the admin edit solution' do
      log_in_as(admin)
      get :edit, id: solution.id
      expect(response).to have_http_status(:success)
    end
  end

  describe '#show' do
    it 'should let anyone view a solution' do
      get :show, id: solution.id
      expect(response).to have_http_status(:success)

      log_in_as(member)
      get :show, id: solution.id
      expect(response).to have_http_status(:success)

      log_in_as(other_member)
      get :show, id: solution.id
      expect(response).to have_http_status(:success)

      log_in_as(admin)
      get :show, id: solution.id
      expect(response).to have_http_status(:success)
    end
  end


  def log_in_as(user)
    allow(controller).to receive(:current_user).and_return(user)
  end

end
