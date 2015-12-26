require 'test_helper'

class UsersPasswordResetsTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:Seulgi)
  end

  test 'password resets' do
    get new_password_reset_path
    assert_template 'password_resets/new'

    # Invalid email submission
    post password_resets_path, password_reset: {email: ''}
    assert_not_empty flash, 'Warning should show for invalid email submission'
    assert_template 'password_resets/new',
                    'Invalid email address submission should redirect back to password reset'

    # Valid email submission
    post password_resets_path, password_reset: {email: @user.email}
    assert_not_equal @user.reset_digest, @user.reload.reset_digest,
                     'Password reset digest should get created for valid reset request'
    assert_equal 1, ActionMailer::Base.deliveries.size,
                 'Email should be sent out for valid password reset request'
    assert_not_empty flash, 'info message should show for valid reset request'
    assert_redirected_to root_url, 'valid reset request should get redirected to the root'

    # Password reset form
    user = assigns(:user)

    # Wrong email
    get edit_password_reset_path(user.reset_token, email: '')
    assert_redirected_to root_url, 'user with wrong email should redirect to the root'

    # Inactive user
    user.toggle!(:activated)
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_redirected_to root_url, 'inactive user should redirect to the root'
    user.toggle!(:activated)

    # Right email, wrong token
    get edit_password_reset_path('wrong token', email: user.email)
    assert_redirected_to root_url, 'valid email with wrong token should redirect to the root'

    # Right email, right token
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_template 'password_resets/edit'
    assert_select 'input[name=email][type=hidden][value=?]', user.email

    # Invalid password & confirmation
    patch password_reset_path(user.reset_token), email: user.email,
          user: {
              password: 'wassup',
              password_confirmation: 'writing codes'
          }
    assert_select 'div#error_explanation'

    # Empty password
    patch password_reset_path(user.reset_token), email: user.email,
          user: {
              password: '',
              password_confirmation: ''
          }
    assert_select 'div#error_explanation'
    assert_template 'password_resets/edit'

    # Valid password & confirmation
    patch password_reset_path(user.reset_token), email: user.email,
          user: {
              password: 'safe_password_!@#',
              password_confirmation: 'safe_password_!@#'
          }
    assert is_logged_in?, 'successful password reset should log user in'
    assert_not_empty flash, 'successful password reset should show success flash'
    assert_redirected_to user, 'successful password reset should redirect user to its profile page'
  end

  test 'expired token' do
    get new_password_reset_path
    post password_resets_path, password_reset: {email: @user.email}

    @user = assigns(:user)
    @user.update_attribute(:reset_sent_at, 3.hours.ago)
    patch password_reset_path(@user.reset_token),
          email: @user.email,
          user: {
              password: 'new_password_!',
              password_confirmation: 'new_password_!'
          }
    assert_response :redirect
    follow_redirect!
    assert_match /expired/i, response.body
  end

end
