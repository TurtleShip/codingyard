require 'test_helper'

class UvaSolutionsControllerTest < ActionController::TestCase

  def setup
    @member = users(:Taejung)
    @language = languages(:cpp)
    @solution = UvaSolution.new_with_relations({problem_number: 123}, @member, @language)
    @solution.save
  end

  test 'logged in user should see links to vote' do
    log_in_as @member
    get :show, id: @solution
    assert_select 'a[href=?]', like_uva_solution_path
    assert_select 'a[href=?]', dislike_uva_solution_path
    assert_select 'a[href=?]', cancel_vote_uva_solution_path
  end

end
