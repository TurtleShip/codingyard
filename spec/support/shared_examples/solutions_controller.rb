RSpec.shared_examples 'SolutionsController' do |solution_factory_name, index_path|

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
      expect(response.status).to eq(200)
    end

    it 'should let an admin upload solution' do
      log_in_as(admin)
      get :new
      expect(response.status).to eq(200)
    end
  end


  describe '#delete' do

    it 'should not let a guest delete solution' do
      delete :destroy, params: {id: solution.id}
      expect(response).to redirect_to send(index_path)
      expect(flash[:danger]).not_to be_nil
    end

    it 'should not let user delete other user\'s solution' do
      log_in_as(other_member)
      delete :destroy, params: {id: solution.id}
      expect(response).to redirect_to send(index_path)
      expect(flash[:danger]).not_to be_nil
    end

    it 'should let the author delete its solution' do
      log_in_as(member)
      delete :destroy, params: {id: solution.id}
      expect(response).to redirect_to send(index_path)
      expect(flash[:success]).not_to be_nil
    end

    it 'should let the admin delete a member\'s solution' do
      log_in_as(admin)
      delete :destroy, params: {id: solution.id}
      expect(response).to redirect_to send(index_path)
      expect(flash[:success]).not_to be_nil
    end
  end


  describe '#edit' do

    it 'should not let a guest edit solution' do
      get :edit, params: {id: solution.id}
      expect(response).to redirect_to send(index_path)
      expect(flash[:danger]).not_to be_nil
    end

    it 'should not let user edit other user\'s solution' do
      log_in_as(other_member)
      get :edit, params: {id: solution.id}
      expect(response).to redirect_to send(index_path)
      expect(flash[:danger]).not_to be_nil
    end

    it 'should let the author its solution' do
      log_in_as(member)
      get :edit, params: {id: solution.id}
      expect(response.status).to eq(200)
    end

    it 'should let the admin edit solution' do
      log_in_as(admin)
      get :edit, params: {id: solution.id}
      expect(response.status).to eq(200)
    end
  end

  describe '#show' do
    it 'should let anyone view a solution' do
      get :show, params: {id: solution.id}
      expect(response.status).to eq(200)

      log_in_as(member)
      get :show, params: {id: solution.id}
      expect(response.status).to eq(200)

      log_in_as(other_member)
      get :show, params: {id: solution.id}
      expect(response.status).to eq(200)

      log_in_as(admin)
      get :show, params: {id: solution.id}
      expect(response.status).to eq(200)
    end
  end

  describe '#like' do
    it 'should not allow guest to vote' do
      expect { post :like, params: {id: solution.id} }.to_not change { solution.get_likes.size }
      expect(flash[:danger]).not_to be_nil
      expect(response).to redirect_to solution
    end

    context 'when logged in as a member' do
      before(:each) { log_in_as(member) }

      it 'should allow voting' do
        expect { post :like, params: {id: solution.id} }.to change { solution.get_likes.size }.by(1)
        expect(flash[:success]).not_to be_nil
        expect(response).to redirect_to solution
      end

      it 'should allow voting only once' do
        expect do
          10.times { post :like, params: {id: solution.id} }
        end.to change { solution.get_likes.size }.by(1)
        expect(flash[:success]).not_to be_nil
        expect(response).to redirect_to solution
      end
    end

    context 'when logged in as admin' do
      before(:each) { log_in_as(admin) }

      it 'should allow voting' do
        expect { post :like, params: {id: solution.id} }.to change { solution.get_likes.size }.by(1)
        expect(flash[:success]).not_to be_nil
        expect(response).to redirect_to solution
      end

      it 'should allow voting only once' do
        expect do
          10.times { post :like, params: {id: solution.id} }
        end.to change { solution.get_likes.size }.by(1)
        expect(flash[:success]).not_to be_nil
        expect(response).to redirect_to solution
      end
    end
  end

  describe '#dislike' do
    it 'should not allow guest to vote' do
      expect { post :dislike, params: {id: solution.id} }.to_not change { solution.get_dislikes.size }
      expect(flash[:danger]).not_to be_nil
      expect(response).to redirect_to solution
    end

    context 'when logged in as a member' do
      before(:each) { log_in_as(member) }

      it 'should allow voting' do
        expect { post :dislike, params: {id: solution.id} }.to change { solution.get_dislikes.size }.by(1)
        expect(flash[:success]).not_to be_nil
        expect(response).to redirect_to solution
      end

      it 'should allow voting only once' do
        expect do
          10.times { post :dislike, params: {id: solution.id} }
        end.to change { solution.get_dislikes.size }.by(1)
        expect(flash[:success]).not_to be_nil
        expect(response).to redirect_to solution
      end
    end

    context 'when logged in as admin' do
      before(:each) { log_in_as(admin) }

      it 'should allow voting' do
        expect { post :dislike, params: {id: solution.id} }.to change { solution.get_dislikes.size }.by(1)
        expect(flash[:success]).not_to be_nil
        expect(response).to redirect_to solution
      end

      it 'should allow voting only once' do
        expect do
          10.times { post :dislike, params: {id: solution.id} }
        end.to change { solution.get_dislikes.size }.by(1)
        expect(flash[:success]).not_to be_nil
        expect(response).to redirect_to solution
      end
    end
  end

  describe '#cancel' do

    context 'when logged in as a member' do

      before(:each) { log_in_as(member) }

      it 'should allow cancel after like' do
        expect { post :like, params: {id: solution.id} }.to change { solution.get_likes.size }.by(1)
        expect { post :cancel_vote, params: {id: solution.id} }.to change { solution.get_likes.size }.by(-1)
        expect(flash[:success]).not_to be_nil
        expect(response).to redirect_to solution
      end

      it 'should allow cancel after dislike' do
        expect { post :dislike, params: {id: solution.id} }.to change { solution.get_dislikes.size }.by(1)
        expect { post :cancel_vote, params: {id: solution.id} }.to change { solution.get_dislikes.size }.by(-1)
        expect(flash[:success]).not_to be_nil
        expect(response).to redirect_to solution
      end
    end

    context 'when logged in as an admin' do

      before(:each) { log_in_as(admin) }

      it 'should allow cancel after like' do
        expect { post :like, params: {id: solution.id} }.to change { solution.get_likes.size }.by(1)
        expect { post :cancel_vote, params: {id: solution.id} }.to change { solution.get_likes.size }.by(-1)
        expect(flash[:success]).not_to be_nil
        expect(response).to redirect_to solution
      end

      it 'should allow cancel after dislike' do
        expect { post :dislike, params: {id: solution.id} }.to change { solution.get_dislikes.size }.by(1)
        expect { post :cancel_vote, params: {id: solution.id} }.to change { solution.get_dislikes.size }.by(-1)
        expect(flash[:success]).not_to be_nil
        expect(response).to redirect_to solution
      end
    end
  end

end

