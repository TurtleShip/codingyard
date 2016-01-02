require 'test_helper'

class TopCoderSrmSolutionsControllerTest < ActionController::TestCase

  def setup
    @member = users(:Taejung)
    @language = languages(:cpp)
    @solution = TopCoderSrmSolution.new_with_relations({srm_number: 123, division_number: 1, difficulty: 'easy'}, @member, @language)
    @solution.save
  end


  test 'logged in user should see links to vote' do
    log_in_as @member
    get :show, id: @solution
    assert_select 'a[href=?]', like_top_coder_srm_solution_path
    assert_select 'a[href=?]', dislike_top_coder_srm_solution_path
    assert_select 'a[href=?]', cancel_vote_top_coder_srm_solution_path
  end

end
