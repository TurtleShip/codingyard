require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user = users(:Seulgi)
    @other_user = users(:Taejung)
  end

  test 'a guest can view index' do
    get :index
    assert_response :success
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

  test 'should redirect edit when logged in as wrong user' do
    log_in_as(@other_user)
    get :edit, id: @user
    assert_not_empty flash
    assert_redirected_to users_path
  end

  test 'should redirect update when logged in as wrong user' do
    log_in_as(@other_user)
    patch :update, id: @user, user: {
                     username: 'valid_new_name'
                 }
    assert_not_empty flash
    assert_redirected_to users_path
  end

  test 'should redirect destroy when not logged in' do
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end

    assert_not_empty flash
    assert_redirected_to login_url
  end

  test 'should redirect destroy when logged in as a non-admin' do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end

    assert_not_empty flash
    assert_redirected_to users_path
  end

end
