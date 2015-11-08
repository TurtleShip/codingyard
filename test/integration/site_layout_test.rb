require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test 'layout link when a user is not logged in' do
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', root_path
    assert_select 'a[href=?]', about_path
  end

end
