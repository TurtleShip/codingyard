require 'test_helper'

class CodeforcesRoundSolutionsControllerTest < ActionController::TestCase

  def setup
    @admin = users(:Seulgi)
    @member = users(:Taejung)
    @other_member = users(:Hansol)
    language = languages(:Java)
    params = {round_number: 1, division_number: 1, level: 'A'}
    @solution = CodeforcesRoundSolution.new_with_relations(params, @member, language)
    @solution.save
  end

  test 'a user must login to upload a solution' do
    get :new
    assert_redirected_to login_path
    assert_not_empty flash, 'redirected page should explain why the user got there'
  end

  test 'a guest cannot delete a solution' do
    delete :destroy, id: @solution.id
    assert_redirected_to root_url
    assert_not_empty flash
  end

  test 'a user cannot delete another users solution' do
    log_in_as @other_member
    delete :destroy, id: @solution.id
    assert_redirected_to root_url
    assert_not_empty flash
  end

  test 'the author can delete its solution' do
    log_in_as @member
    delete :destroy, id: @solution.id
    assert_redirected_to codeforces_round_solutions_url
    assert_not_empty flash
  end

  test 'An admin can delete member\'s solution' do
    log_in_as @admin
    delete :destroy, id: @solution.id
    assert_redirected_to codeforces_round_solutions_url
    assert_not_empty flash
  end

end
