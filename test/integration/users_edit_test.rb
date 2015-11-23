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

    log_in_as(@user)
    assert_redirected_to edit_user_path(@user), 'user should return to edit page after logging in'

    get edit_user_path(@user)
    assert_template 'users/edit'
    username = 'remember_yolo'
    email = 'valid@email.com'
    password = 'safe_password_123_!@$'

    patch user_path(@user), user: {
                              username: username,
                              email: email,
                              password: password,
                              password_confirmation: password
                          }

    assert_not_empty flash
    assert_redirected_to @user

    @user.reload
    assert_equal username, @user.username
    assert_equal email, @user.email
    assert @user.authenticate(password)
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
