require 'rails_helper'

# Contains tests related to validations in User model
describe User do

  # validations
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  # username validation
  it 'is invalid without username' do
    expect(build(:user, username: nil)).to_not be_valid
  end

  it 'is invalid with blank username' do
    expect(build(:user, username: '')).to_not be_valid
    expect(build(:user, username: '         ')).to_not be_valid
  end

  it 'should have unique username' do
    user = create(:user)
    expect(build(:user, username: user.username)).to_not be_valid
  end

  it 'should have alphanumeric username with hyphen and underscore' do
    expect(build(:user, username: '!@#$%^&*()+')).to_not be_valid
    expect(build(:user, username: 'abCd-_-123')).to be_valid
  end

  it 'should have username of length between 3 and 20, inclusive' do
    expect(build(:user, username: 'ab')).to_not be_valid
    expect(build(:user, username: 'a' * 21)).to_not be_valid
    expect(build(:user, username: 'a' * 3)).to be_valid
    expect(build(:user, username: 'a' * 20)).to be_valid
  end

  # email validation
  it 'should have valid email' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                             first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      expect(build(:user, email: valid_address)).to be_valid
    end
  end

  it 'should not have invalid email' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                               foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      expect(build(:user, email: invalid_address)).to_not be_valid
    end
  end

  it 'should not have duplicate email' do
    user = create(:user)
    expect(build(:user, email: user.email)).to_not be_valid
  end

  # firstname validation
  it 'may not have firstname' do
    expect(build(:user, firstname: nil)).to be_valid
  end

  it 'can have valid firstname' do
    valid_first_names = ['Wassup', 'King George III', 'Mike-Ikerson', 'foreigner12', 'O\'reily']
    valid_first_names.each do |valid_first_name|
      expect(build(:user, firstname: valid_first_name)).to be_valid
    end
  end

  it 'should not have invalid firstname' do
    invalid_first_names = ['drop-database;', 'select *', 'the bangs!!!']
    invalid_first_names.each do |valid_first_name|
      expect(build(:user, firstname: valid_first_name)).to_not be_valid
    end
  end

  # lastname validation
  it 'may not have lastname' do
    expect(build(:user, lastname: nil)).to be_valid
  end

  it 'can have valid lastname' do
    valid_last_names = ['Wassup', 'King George III', 'Mike-Ikerson', 'foreigner12', 'O\'reily']
    valid_last_names.each do |valid_last_name|
      expect(build(:user, firstname: valid_last_name)).to be_valid
    end
  end

  it 'should not have invalid firstname' do
    invalid_last_names = ['drop-database;', 'select *', 'the bangs!!!']
    invalid_last_names.each do |valid_last_name|
      expect(build(:user, firstname: valid_last_name)).to_not be_valid
    end
  end

  # password validation
  it 'should have password' do
    expect(build(:user, password_digest: User.digest(nil), password: nil)).to_not be_valid
  end

  it 'should not have a blank password' do
    blank = ' ' * 10
    expect(build(:user, password_digest: User.digest(blank), password: blank)).to_not be_valid
  end

  it 'should have password at least 6 characters long' do
    short_password = 'a' * 3
    valid_password = 'a' * 10
    expect(build(:user, password_digest: User.digest(short_password), password: short_password)).to_not be_valid
    expect(build(:user, password_digest: User.digest(valid_password), password: valid_password)).to be_valid
  end

end


