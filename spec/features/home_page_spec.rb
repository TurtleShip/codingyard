require 'rails_helper'
require 'support/features/features_helpers'

RSpec.feature 'Home page', type: :feature do

  let(:member) { create(:user) }
  let(:admin) { create(:admin_user) }

  scenario 'for guest' do
    visit_home
    see_guest_views
  end

  scenario 'for member' do
    login(member)
    visit_home
    see_member_views
  end

  scenario 'for admin' do
    login(admin)
    visit_home
    see_admin_views
  end

end

def visit_home
  visit('/')
  expect(page).to have_current_path(root_path)
end

def see_guest_views
  see_link_to_home
  see_links_to_view_solutions
  see_links_to_source_repo
  see_links_to_about_and_Seulgi
end

def see_member_views
  see_guest_views
  see_links_to_upload_solutions
end

def see_admin_views
  see_member_views
end

def see_link_to_home
  expect(page).to have_link('Codingyard', href: root_path)
end

def see_links_to_view_solutions
  expect(page).to have_link('Codeforces', href: codeforces_round_solutions_path)
  expect(page).to have_link('TopCoder SRM', href: top_coder_srm_solutions_path)
  expect(page).to have_link('UVa Online Judge', href: uva_solutions_path)
end

def see_links_to_upload_solutions
  expect(page).to have_link('Codeforces', href: new_codeforces_round_solution_path)
  expect(page).to have_link('TopCoder SRM', href: new_top_coder_srm_solution_path)
  expect(page).to have_link('UVa Online Judge', href: new_uva_solution_path)
end

def see_links_to_source_repo
  expect(page).to have_link('Fork me on Github', href: 'https://github.com/TurtleShip/codingyard')
  expect(page).to have_link('Report an issue', href: 'https://github.com/TurtleShip/codingyard/issues')
end

def see_links_to_about_and_Seulgi
  expect(page).to have_link('About', href: about_path)
  expect(page).to have_link('Seulgi Kim', href: 'https://www.linkedin.com/in/Seulgi')
end