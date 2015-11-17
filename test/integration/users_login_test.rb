require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:Seulgi)
  end

  test 'login with invalid information' do
    get login_path
    assert_template 'sessions/new', 'login path should display sessions/new template'

    post login_path, session: {
                       username: '',
                       password: ''
                   }

    assert_template 'sessions/new', 'unsuccessful login should re-render login page'
    assert_not_empty flash, 'unsuccessful login should display error message'

    get root_path
    assert_empty flash, 'flash message should not persist when a user moves out of a login page'
  end

  test 'login with valid information' do
    get login_path
    assert_template 'sessions/new', 'login path should display sessions/new template'

    post login_path, session: {
                       username: @user.username,
                       password: 'password'
                   }

    assert_redirected_to @user, 'Valid login should redirect the user to its profile page'
    follow_redirect!

    assert_template 'users/show', 'Redirected user after login should land on its profile page'

    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', logout_path
    assert_select 'a[href=?]', user_path(@user)
  end
end
