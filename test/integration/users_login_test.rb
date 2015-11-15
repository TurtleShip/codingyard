require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

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
end
