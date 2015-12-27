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

end
