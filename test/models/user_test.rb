require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(username: 'TurtleShip', email: 'awesome@coder.com')
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

  test 'email validation should accept valid addresses' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test 'email validation should reject invalid addresses' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test 'email addresses should be unique in a case-insensitive way' do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'email addresses should be downcased when saved' do
    original_email = 'HeLLo@wasSuP.CoM'
    @user.email = original_email
    @user.save
    assert_equal original_email.downcase, @user.email, 'email should be downcased after being saved'
  end

end
