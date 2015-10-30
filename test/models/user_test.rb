require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(username: 'TurtleShip')
  end

  test 'An example user should be valid' do
    assert @user.valid?
  end

  test 'Username cannot be nil' do
    @user.username = nil
    assert_not @user.valid?
  end

  test 'Username cannot be empty' do
    @user.username = ''
    assert_not @user.valid?

    @user.username = '      '
    assert_not @user.valid?
  end

  test 'Username must be unique' do
    @user.save
    duplicate_user = User.new(username: @user.username)
    assert_not duplicate_user.valid?
  end

  test 'username must be alphanumeric with hyphen and underscore' do
    @user.username = '!@#$%^&*()+'
    assert_not @user.valid?

    @user.username = 'abCd-_-123'
    assert @user.valid?
  end

  test 'username must 3 to 20 characters long' do
    @user.username ='ab'
    assert_not @user.valid?

    @user.username = 'a' * 21
    assert_not @user.valid?

    @user.username = 'abc'
    assert @user.valid?

    @user.username = 'a' * 20
    assert @user.valid?
  end

end
