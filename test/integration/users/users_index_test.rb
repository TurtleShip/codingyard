require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:Seulgi)
    @member = users(:Taejung)
  end

  test 'index as admin including pagination and delete links' do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'

    first_page_of_users = User.paginate(page: 1, :per_page => User::PER_PAGE)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: 'Details'
      assert_select 'a[href=?]',edit_user_path(user), text: 'edit' if user == @admin
      assert_select 'a[data-method="delete"]', :href => user_path(user) unless user == @admin
    end

    assert_difference 'User.count', -1 do
      delete user_path(@member)
    end
  end

  test 'index as member' do
    log_in_as(@member)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'

    first_page_of_users = User.paginate(page: 1, :per_page => User::PER_PAGE)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: 'Details'
      assert_select 'a[href=?]',edit_user_path(user), text: 'edit', count: (user == @member ? 1 : 0)
      assert_select 'td', user.codeforces_handle
      assert_select 'td', user.topcoder_handle
      assert_select 'td', user.uva_handle
    end

  end
end
