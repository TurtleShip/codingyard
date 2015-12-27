require 'test_helper'

class TopCoderSrmSolutionsControllerTest < ActionController::TestCase

  def setup
    @member = users(:Taejung)
    @language = languages(:cpp)
    @solution = TopCoderSrmSolution.new_with_relations({srm_number: 123, division_number: 1, difficulty: 'easy'}, @member, @language)
    @solution.save
  end

  test 'user need to login to vote' do
    assert_no_difference '@solution.votes_for.size', 'A guest cannot make a vote' do
      post :like, {id: @solution}
    end
    assert_not_empty flash[:danger]
    assert_redirected_to @solution
  end

  test 'logged in user should see links to vote' do
    log_in_as @member
    get :show, id: @solution
    assert_select 'a[href=?]', like_top_coder_srm_solution_path
    assert_select 'a[href=?]', dislike_top_coder_srm_solution_path
    assert_select 'a[href=?]', cancel_vote_top_coder_srm_solution_path
  end

  test 'user can like a solution' do
    log_in_as @member
    assert_difference '@solution.get_likes.size', 1, 'User can like' do
      post :like, {id: @solution}
    end
    assert_not_empty flash[:success]
    assert_redirected_to @solution
  end

  test 'user can dislike a solution' do
    log_in_as @member
    assert_difference '@solution.get_dislikes.size', 1, 'User can dislike' do
      post :dislike, {id: @solution}
    end
    assert_not_empty flash[:success]
    assert_redirected_to @solution
  end

  test 'user can cancel its vote' do
    log_in_as @member
    assert_difference '@solution.get_likes.size', 1, 'User can like' do
      post :like, {id: @solution}
    end
    assert_not_empty flash[:success]
    assert_redirected_to @solution

    assert_difference '@solution.get_likes.size', -1, 'User can cancel like' do
      post :cancel_vote, {id: @solution}
    end
    assert_not_empty flash[:success]
    assert_redirected_to @solution


    assert_difference '@solution.get_dislikes.size', 1, 'User can dislike' do
      post :dislike, {id: @solution}
    end
    assert_not_empty flash[:success]
    assert_redirected_to @solution

    assert_difference '@solution.get_dislikes.size', -1, 'User can cancel dislike' do
      post :cancel_vote, {id: @solution}
    end
    assert_not_empty flash[:success]
    assert_redirected_to @solution
  end

  test 'user can vote only once' do
    log_in_as @member

    assert_difference '@solution.get_likes.size', 1, 'User can like only once' do
      10.times { post :like, {id: @solution} }
    end

    assert_difference '@solution.get_dislikes.size', 1, 'User can dislike only once' do
      10.times { post :dislike, {id: @solution} }
    end
  end
end
