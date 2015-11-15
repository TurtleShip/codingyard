require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

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

  test 'valid signup' do
    get signup_path

    assert_difference 'User.count', 1, 'valid form submission should create a new user' do
      post_via_redirect users_path, user: {
                                      username: 'valid_username',
                                      email: 'valid@email.com',
                                      password: 'safe_password_123_!@$',
                                      password_confirmation: 'safe_password_123_!@$'
                                  }

    end
    assert_template 'users/show', 'successful signup should direct a user to its profile page'
    assert_not_empty flash, 'success flash should be displayed on successful signup'
  end

end
