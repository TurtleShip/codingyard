require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @admin = users(:Seulgi)
    @member = users(:Taejung)
    @other_member = users(:Hansol)
  end

  test 'a guest can view index' do
    get :index
    assert_response :success
  end

  test 'should redirect edit when not logged in' do
    get :edit, id: @member
    assert_not_empty flash
    assert_redirected_to login_url
  end

  test 'should redirect update when not logged in' do
    patch :update, id: @member, user: {
                     username: 'valid_new_name'
                 }
    assert_not_empty flash
    assert_redirected_to login_url
  end

  test 'should redirect edit when logged in as wrong user' do
    log_in_as(@other_member)
    get :edit, id: @member
    assert_not_empty flash
    assert_redirected_to users_path
  end

  test 'should redirect update when logged in as wrong user' do
    log_in_as(@other_member)
    patch :update, id: @member, user: {
                     username: 'valid_new_name'
                 }
    assert_not_empty flash
    assert_redirected_to users_path
  end

  test 'should redirect destroy when not logged in' do
    assert_no_difference 'User.count' do
      delete :destroy, id: @member
    end

    assert_not_empty flash
    assert_redirected_to login_url
  end

  test 'should redirect destroy when logged in as a non-admin' do
    log_in_as(@other_member)
    assert_no_difference 'User.count' do
      delete :destroy, id: @member
    end

    assert_not_empty flash
    assert_redirected_to users_path
  end
  
  test 'a guest cannot see a member email' do
    get :show, id: @member.id
    user_info = assigns(:user_basic_info)
    assert_nil user_info[:email]
  end

  test 'a member cannot see other member email' do
    log_in_as @other_member
    get :show, id: @member.id
    user_info = assigns(:user_basic_info)
    assert_nil user_info[:email]
  end

  test 'a member can see its own email' do
    log_in_as @member
    get :show, id: @member
    user_info = assigns(:user_basic_info)
    assert_not_nil user_info[:email]
  end

  test 'an admin can see any member email' do
    log_in_as @admin
    get :show, id: @member
    user_info = assigns(:user_basic_info)
    assert_not_nil user_info[:email]
  end
end
