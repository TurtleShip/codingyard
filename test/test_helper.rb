ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  # Returns true if a test user is logged in.
  def is_logged_in?
    !session[:user_id].nil?
  end

  # Logs in a test user.
  # By default (i.e. when not opt is provided), password defaults to 'password'
  # and 'remember_me' defaults to '1'
  def log_in_as(user, options = {})
    password = options[:password] || 'password'
    remember_me = options[:remember_me] || '1'
    if integration_test?
      post login_path, session: {
                         username: user.username,
                         password: password,
                         remember_me: remember_me
                     }
    else
      session[:user_id] = user.id
    end
  end

  private
    # Returns true inside an integration test.
    def integration_test?
      defined?(post_via_redirect)
    end

end
