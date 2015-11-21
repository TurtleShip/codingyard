require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user = users(:Seulgi)
  end

  test 'should redirect edit when not logged in' do
    get :edit, id: @user
    assert_not_empty flash
    assert_redirected_to login_url
  end

  test 'should redirect update when not logged in' do
    patch :update, id: @user, user: {
                     username: 'valid_new_name'
                 }
    assert_not_empty flash
    assert_redirected_to login_url
  end

end
