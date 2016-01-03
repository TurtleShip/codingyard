require 'rails_helper'
require 'support/features/features_helpers'

RSpec.feature 'Login', type: :feature do

  let(:user) { create(:user) }


  scenario 'with invalid cred' do
    login_with(user.username, 'wrong password')
    render_login_and_show_flash_warning

    # flash message should not persist when a user moves out of a login page
    visit '/'
    expect(page).to_not have_text('Invalid email/password combination')
  end

  scenario 'valid credential followed by log out' do
    visit '/login'
    sees_forgot_password_link
    sees_resend_activation_link
    sees_remember_me_checkbox

    login(user)

    # Should redirect to user profile page when logged in
    expect(page).to have_current_path(user_path(user))

    # Time to logout
    click_link('Log out')
    expect(page).to have_current_path(root_path)
    expect(page).to have_text('Login')
    expect(page).to have_text('Signup')
  end


end

def sees_forgot_password_link
  expect(page).to have_link('(forgot password)', new_password_reset_path)
end

def sees_resend_activation_link
  expect(page).to have_link('(resend activation link)', new_account_activation_path)
end

def sees_remember_me_checkbox
  expect(page).to have_text('Remember me on this computer')
end

def render_login_and_show_flash_warning
  # unsuccessful login should re-render login page
  expect(page).to have_current_path(login_path)
  # and also display flash warning
  expect(page).to have_text('Invalid email/password combination')
end