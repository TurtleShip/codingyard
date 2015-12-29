require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:Seulgi)
    @member = users(:Taejung)
  end

  test 'unsuccessful edit' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: {
                              username: 'TurtleShipNewName',
                              email: 'invalidEmail',
                              password: 'match',
                              password_confirmation: 'no-match'
                          }
    assert_template 'users/edit', 'unsuccessful edit should redirect the user back to edit page'
  end

  test 'successful edit with friendly forwarding' do
    get edit_user_path(@user)
    assert_redirected_to login_path, 'a guest trying to access unauthorized edit page should be redirected to log in page'
    assert_not_nil session[:forwarding_url]

    log_in_as(@user)
    assert_redirected_to edit_user_path(@user), 'user should return to edit page after logging in'

    get edit_user_path(@user)
    assert_template 'users/edit'
    username = 'remember_yolo'
    email = 'valid@email.com'
    password = 'safe_password_123_!@$'
    codeforces_handle = 'TurtleShip'

    patch user_path(@user), user: {
                              username: username,
                              email: email,
                              password: password,
                              password_confirmation: password,
                              codeforces_handle: codeforces_handle
                          }

    assert_not_empty flash
    assert_redirected_to @user
    assert_nil session[:forwarding_url]

    @user.reload
    assert_equal username, @user.username
    assert_equal email, @user.email
    assert_equal codeforces_handle, @user.codeforces_handle
    assert @user.authenticate(password)

    get user_path(@user)
    assert_select 'p', text: username
    assert_select 'div.user_info_value', text: email
    assert_select 'div.user_info_value', text: codeforces_handle

  end

  test 'edit with no password change' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    original_password = 'password'
    empty_password = ''
    patch user_path(@user), user: {
                            password: empty_password,
                            password_confirmation: empty_password
                          }
    @user.reload

    assert_not @user.authenticate(empty_password)
    assert @user.authenticate(original_password)
  end

  test 'admin param should not be edited by anyone' do
    log_in_as(@member)
    get edit_user_path(@member)
    patch user_path(@member), user: {
              admin: true
                          }
    @member.reload
    assert_not @member.admin?
  end

end
