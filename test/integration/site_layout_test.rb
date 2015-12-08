require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @member = users(:Taejung)
  end

  test 'layout links when a user is not logged in' do
    get root_path
    assert_template 'static_pages/home'

    # Headers
    assert_select 'a[href=?]', root_path
    assert_select 'a[href=?]', codeforces_round_solutions_path
    assert_select 'a[href=?]', login_path
    assert_select 'a[href=?]', signup_path

    # Content
    assert_select 'a[href=?]', 'https://github.com/TurtleShip/codingyard'

    # Footer
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', 'https://www.linkedin.com/in/Seulgi'
  end

  test 'layout links when a user is logged in' do
    log_in_as @member

    get root_path
    assert_template 'static_pages/home'

    # Headers
    assert_select 'a[href=?]', root_path # Codingyard
    assert_select 'a[href=?]', codeforces_round_solutions_path # Solutions
    assert_select 'a[href=?]', new_codeforces_round_solution_path # Upload
    assert_select 'a[href=?]', users_path # Users
    assert_select 'a[href=?]', user_path(@member) # Profile
    assert_select 'a[href=?]', edit_user_path(@member) # Settings

    # Footer
    assert_select 'a[href=?]', about_path # About
    assert_select 'a[href=?]', 'https://www.linkedin.com/in/Seulgi'
  end

end
