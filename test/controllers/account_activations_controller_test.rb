require 'test_helper'

class AccountActivationsControllerTest < ActionController::TestCase

  def setup
    @member = users(:Taejung)
    ActionMailer::Base.deliveries.clear
  end

  test 'Already activated user should not be allowed for "send activation link"' do
    post :create, {email: @member.email}
    assert_equal 0, ActionMailer::Base.deliveries.size, 'Already activated user should not get a new activation email'
    assert_redirected_to login_path
  end

  test 'Non existing user should not get activation link' do
    post :create, {email: 'hello@nonexistent.com'}
    assert_equal 0, ActionMailer::Base.deliveries.size, 'Non-existing user should not get an activation email'
    assert_not_empty flash[:danger]
    assert_redirected_to new_account_activation_path
  end

  # Test for not activated user trying to send activation link is in integration test AccountActivationSendLinkTest.
  test 'A not activated user should get an activation link' do
    @member.activated = false
    @member.save

    post :create, {email: @member.email}
    assert_equal 1, ActionMailer::Base.deliveries.size, 'A non activated user should get an activation email'

    assert_redirected_to login_path
  end

end
