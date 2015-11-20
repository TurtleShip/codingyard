require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:Seulgi)
  end

  test 'unsuccessful edit' do
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

  test 'successful edit' do
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

end
