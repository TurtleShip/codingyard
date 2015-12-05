require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = users(:Seulgi)
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

  test 'Username must be unique in a case insensitive way' do
    @user.save
    duplicate_user = @user.dup
    duplicate_user.username.upcase!
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
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
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

  test 'firstname can be skipped' do
    @user.firstname = nil
    assert @user.valid?
  end

  test 'firstname should accept valid names' do
    valid_names = ['Wassup', 'King George III', 'Mike-Ikerson', 'foreigner12', "O'reily"]
    valid_names.each do |name|
      @user.firstname = name
      assert @user.valid?, "#{name} should be valid"
    end
  end

  test 'firstname should reject invalid names' do
    invalid_names = ['drop-database;', 'select *', 'the bangs!!!']
    invalid_names.each do |name|
      @user.firstname = name
      assert_not @user.valid?, "#{name} should be invalid"
    end
  end

  test 'lastname can be skipped' do
    @user.lastname = nil
    assert @user.valid?
  end

  test 'lastname should accept valid names' do
    valid_names = ['Wassup', 'King George III', 'Mike-Ikerson', 'foreigner12']
    valid_names.each do |name|
      @user.lastname = name
      assert @user.valid?, "#{name} should be valid"
    end
  end

  test 'lastname should reject invalid names' do
    invalid_names = ['drop-database;', 'select *', 'the bangs!!!']
    invalid_names.each do |name|
      @user.lastname = name
      assert_not @user.valid?, "#{name} should be invalid"
    end
  end

  test 'password should be present (nonblank)' do
    @user.password = @user.password_confirmation = ' ' * 6
    assert_not @user.valid?
  end
  test 'password should have a minimum length' do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end

  test 'deleting user should delete topcoder srm solutions' do
    num_solutions = 5
    top_coder = contests(:TopCoder)

    num_solutions.times do
      @user.top_coder_srm_solutions.create(contest_id: top_coder.id, srm_number: 1, division_number: 1, difficulty: 'easy')
    end

    assert_equal num_solutions, TopCoderSrmSolution.count

    @user.destroy
    assert_equal 0, TopCoderSrmSolution.count, 'Deleting user should delete its Topcoder srm solutions as well'
  end

  test 'deleting user should delete codeforces round solutions' do
    num_solutions = 5
    num_solutions.times do
      CodeforcesRoundSolution.new_with_relations({round_number: 1, division_number: 1, level: 'A'}, @user, languages(:Java))
    end

    assert_equal num_solutions, CodeforcesRoundSolution.count

    @user.destroy
    assert_equal 0, CodeforcesRoundSolution.count, 'Deleting user should delete its Codeforces round solutions as well'
  end

  test 'authenticated? should return false for a user with nil digest' do
    assert_not @user.authenticated?(:remember, '')
  end

end
