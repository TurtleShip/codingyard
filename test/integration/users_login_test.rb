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

  test 'login with valid information followed by logout' do
    get login_path
    assert_template 'sessions/new', 'login path should display sessions/new template'

    post login_path, session: {
                       username: @user.username,
                       password: 'password'
                   }

    assert is_logged_in?, 'User should be logged in with its correct credential'
    assert_redirected_to @user, 'Valid login should redirect the user to its profile page'
    follow_redirect!

    assert_template 'users/show', 'Redirected user after login should land on its profile page'

    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', logout_path
    assert_select 'a[href=?]', user_path(@user)

    # Logging out
    delete logout_path
    assert_not is_logged_in?, 'Logout path should log the current user out'
    assert_redirected_to root_url, 'logging out should redirect to the root url'

    # Simulate a user clicking logout in a second window
    # so that we catch any regression for a scenario where a user has two browsers open,
    # logs out in the first browser, and tries to log out in the second browser.
    # Our app should NOT throw any errors (i.e. gracefully handle ) in this scenario.
    delete logout_path

    follow_redirect!

    assert_select 'a[href=?]', login_path, {}, 'root url with no signed in user should show login path'
    assert_select 'a[href=?]', logout_path, {count: 0}, 'root url with no signed in user should not show logout path'
    assert_select 'a[href=?]', user_path(@user), {count: 0}, 'root url with no signed in user should not show link to profile page'
  end

  test 'login with "remember me" checked' do
    log_in_as(@user, remember_me: '1')
    assert_equal cookies['remember_token'], assigns(:user).remember_token
  end

  test 'login with "remember me" NOT checked' do
    log_in_as(@user, remember_me: '0')
    assert_nil cookies['remember_token']
  end

end
