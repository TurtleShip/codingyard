require 'test_helper'

class CodeforcesRoundSolutionsControllerTest < ActionController::TestCase

  def setup
    @admin = users(:Seulgi)
    @member = users(:Taejung)
    @other_member = users(:Hansol)
    language = languages(:Java)
    params = {round_number: 1, division_number: 1, level: 'A'}
    params_other = { round_number: 3, division_number: 2, level: 'B'}
    @solution = CodeforcesRoundSolution.new_with_relations(params, @member, language)
    @solution.save
    @other_solution = CodeforcesRoundSolution.new_with_relations(params_other, @other_member, language)
    @other_solution.save
  end

  test 'a user must login to upload a solution' do
    get :new
    assert_redirected_to login_path
    assert_not_nil flash[:danger], 'redirected page should explain why the user got there'
  end

  test 'a member can upload a solution' do
    log_in_as @member
    get :new
    assert_response :success
  end

  test 'an admin can upload a solution' do
    log_in_as @admin
    get :new
    assert_response :success
  end

  test 'a guest cannot delete a solution' do
    delete :destroy, id: @solution.id
    assert_redirected_to root_url
    assert_not_nil flash[:danger]
  end

  test 'a user cannot delete another users solution' do
    log_in_as @other_member
    delete :destroy, id: @solution.id
    assert_redirected_to root_url
    assert_not_nil flash[:danger]
  end

  test 'the author can delete its solution' do
    log_in_as @member
    delete :destroy, id: @solution.id
    assert_redirected_to codeforces_round_solutions_url
    assert_not_nil flash[:success]
  end

  test 'An admin can delete member\'s solution' do
    log_in_as @admin
    delete :destroy, id: @solution.id
    assert_redirected_to codeforces_round_solutions_url
    assert_not_nil flash[:success]
  end

  test 'a guest cannot edit solution' do
    get :edit, id: @solution.id
    assert_redirected_to root_url
    assert_not_nil flash[:danger]
  end

  test 'non-author cannot edit solution' do
    log_in_as @other_member
    get :edit, id: @solution.id
    assert_redirected_to root_url
    assert_not_nil flash[:danger]
  end

  test 'the author can edit solution' do
    log_in_as @member
    get :edit, id: @solution.id
    assert_response :success
  end

  test 'an admin can edit solution' do
    log_in_as @admin
    get :edit, id: @solution.id
    assert_response :success
  end


  test 'anyone can view a solution' do
    get :show, id: @solution.id
    assert_response :success

    assert_select 'div.solution_display_value', @solution.round_number.to_s
    assert_select 'div.solution_display_value', @solution.division_number.to_s
    assert_select 'div.solution_display_value', @solution.level
    assert_select 'div.solution_display_value', @solution.language.name
  end

  test 'anyone can view all solutions' do
    get :index
    assert_response :success

    assert_select 'td', @member.username
    assert_select 'td', @solution.language.name
    assert_select 'td', @solution.round_number.to_s
    assert_select 'td', @solution.division_number.to_s
    assert_select 'td', @solution.level
    assert_select 'a[href=?]', codeforces_round_solution_path(@solution)
    assert_select 'a[data-method="delete"]', :href => codeforces_round_solution_path(@solution)

    assert_select 'td', @other_member.username
    assert_select 'td', @other_solution.language.name
    assert_select 'td', @other_solution.round_number.to_s
    assert_select 'td', @other_solution.division_number.to_s
    assert_select 'td', @other_solution.level
    assert_select 'a[href=?]', codeforces_round_solution_path(@other_solution)
    assert_select 'a[data-method="delete"]', :href => codeforces_round_solution_path(@other_solution)
  end

end
