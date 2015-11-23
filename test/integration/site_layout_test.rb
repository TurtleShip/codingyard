require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @member = users(:Taejung)
  end

  test 'layout links when a user is not logged in' do
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', root_path
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', login_path
    assert_select 'a[href=?]', signup_path
  end

  test 'layout links when a user is logged in' do
    log_in_as @member
    get root_path
    assert_select 'a[href=?]', root_path
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', user_path(@member)
    assert_select 'a[href=?]', edit_user_path(@member)
    assert_select 'a[href=?]', logout_path
  end

end
