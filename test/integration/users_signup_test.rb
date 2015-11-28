require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test 'invalid signup' do
    get signup_path

    assert_no_difference 'User.count', 'invalid form submission should not create a new user' do
      post users_path, user: {
                         username: 'TurtleShip',
                         email: 'aweseomc@coder.com',
                         password: 'match',
                         password_confirmation: 'no-match'
                     }
    end

    assert_template 'users/new', 'unsuccessful signup should redirect back to signup page'
    assert_template({partial: 'shared/_error_messages'}, 'The new signup page should show error messages')
  end

  test 'valid signup with account activation' do
    get signup_path

    assert_difference 'User.count', 1, 'valid form submission should create a new user' do
      post users_path, user: {
                         username: 'valid_username',
                         email: 'valid@email.com',
                         password: 'safe_password_123_!@$',
                         password_confirmation: 'safe_password_123_!@$'
                     }
    end

    assert_equal 1, ActionMailer::Base.deliveries.size, 'A new user should get an activation email'

    user = assigns(:user)
    assert_not user.activated?, 'A new user should not be in "activated" state'

    log_in_as(user)
    assert_not is_logged_in?, 'A new user should not be able to login without activating its account first'

    # Index page
    # Log in as valid user.
    log_in_as(users(:Seulgi))

    # There are 33 users, with 10 per page. So if new user shows up, it will be on 4th page.
    get users_path, page: 4
    assert_no_match user.username, response.body, 'Unactivated user should not show up on user idnex page'

    # Profile page
    get user_path(user)
    assert_redirected_to root_url, 'Unactivated user should not have profile page'

    # Log out valid user.
    delete logout_path

    get edit_account_activation_path('Invalid token')
    assert_not is_logged_in?, 'A new user should not be able to activate its account with invalid token'

    # Valid token, wrong email
    get edit_account_activation_path(user.activation_token, email: 'invalid')
    assert_not is_logged_in?, 'A new user with valid activation token and invalid email' +
                                'should not be able to activate its account'

    # Valid activation token
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?, 'A new user can activate its account with valid activation token and valid email'
    follow_redirect!
    assert_template 'users/show', 'Successful activation should redirect the current user to profile page'
    assert is_logged_in?, 'Successful activation should log the user in'
  end

end
