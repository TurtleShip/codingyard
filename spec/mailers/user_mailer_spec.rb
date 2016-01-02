require 'rails_helper'

# Matchers from email spec library: https://github.com/bmabey/email-spec

RSpec.describe UserMailer, type: :mailer do

  let(:user) { create(:user) }

  describe 'account_activation' do
    let(:mail) { UserMailer.account_activation(user) }

    it 'renders the subject' do
      expect(mail).to have_subject('Account activation')
    end

    it 'renders the receiver email' do
      expect(mail).to deliver_to(user.email)
    end

    it 'renders the sender email' do
      expect(mail).to deliver_from('codingyard@gmail.com')
    end

    it 'contains username in email body' do
      expect(mail).to have_body_text(user.username)
    end

    it 'contains activation link' do
      activation_link = edit_account_activation_url(user.activation_token, email: user.email)
      expect(mail).to have_body_text(activation_link)
    end
  end

  describe 'password_reset' do
    let(:mail) { UserMailer.password_reset(user) }

    before(:each) do
      user.reset_token = User.new_token
    end

    it 'renders the subject' do
      expect(mail).to have_subject('Password reset')
    end

    it 'renders the receiver email' do
      expect(mail).to deliver_to(user.email)
    end

    it 'renders the sender email' do
      expect(mail).to deliver_from('codingyard@gmail.com')
    end

    it 'contains username in email body' do
      expect(mail).to have_body_text(user.username)
    end

    it 'contains password reset link' do
      reset_link = edit_password_reset_url(user.reset_token, email: user.email)
      expect(mail).to have_body_text(reset_link)
    end
  end

end
