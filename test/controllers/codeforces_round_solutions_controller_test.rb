require 'test_helper'

class CodeforcesRoundSolutionsControllerTest < ActionController::TestCase

  test 'a user must login to upload a solution' do
    get :new
    assert_redirected_to login_path
    assert_not_empty flash, 'redirected page should explain why the user got there'
  end

end
