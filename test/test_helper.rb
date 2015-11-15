ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def valid_user
    user = users(:Seulgi)
    user.password =  'safePassword!'
    user.password_confirmation = 'safePassword!'
    user
  end
end
