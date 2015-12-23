require 'test_helper'

# I am including it so that I can use 'fixture_file_upload'
# If there is a way to upload a file with just ActionDispatch::IntegrationTest
# Please feel free to remove 'ActionDispatch::TestProcess' and use that approach
include ActionDispatch::TestProcess

class CodeforcesUploadTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:Seulgi)
    @member = users(:Taejung)
    @other_member = users(:Hansol)
    @language = languages(:cpp)
  end

  test 'upload with friendly forwarding' do

    get new_codeforces_round_solution_path
    assert_redirected_to login_path, 'user should be redirected to login page' +
                                       ' when trying to upload a solution without being logged in'

    log_in_as @member
    assert_redirected_to new_codeforces_round_solution_path,
                         'user should redirected back to solution upload page'

    follow_redirect!
    assert_template 'codeforces_round_solutions/new', 'new.html.erb should be rendered when redirected back to upload page'

    # Provide no data
    post codeforces_round_solutions_path
    assert_template 'codeforces_round_solutions/new', 'unsuccessful upload should redirect back to upload page'
    assert_template({partial: 'shared/_error_messages'}, 'unsuccessful upload should display errors')
    assert_empty flash

    # Provide codeforces_round_solution with no data
    post codeforces_round_solutions_path, {codeforces_round_solution: {}}
    assert_template 'codeforces_round_solutions/new', 'unsuccessful upload should redirect back to upload page'
    assert_template({partial: 'shared/_error_messages'}, 'unsuccessful upload should display errors')
    assert_empty flash

    # Correct codeforces_round_solution but missing language
    post codeforces_round_solutions_path,
         {
             codeforces_round_solution: {
                 round_number: 325,
                 division_number: 1,
                 level: 'A',
                 attachment: fixture_file_upload('/files/codeforces/C.java', 'text/plain')
             }
         }
    assert_template 'codeforces_round_solutions/new', 'unsuccessful upload should redirect back to upload page'
    assert_template({partial: 'shared/_error_messages'}, 'unsuccessful upload should display errors')
    assert_empty flash

    # Missing round_number
    post codeforces_round_solutions_path,
         {
             codeforces_round_solution: {
                 division_number: 1,
                 level: 'A',
                 attachment: fixture_file_upload('/files/codeforces/C.java', 'text/plain')
             },
             language: @language.name
         }
    assert_template 'codeforces_round_solutions/new', 'unsuccessful upload should redirect back to upload page'
    assert_template({partial: 'shared/_error_messages'}, 'unsuccessful upload should display errors')
    assert_empty flash

    # Incorrect division number
    post codeforces_round_solutions_path,
         {
             codeforces_round_solution: {
                 round_number: 115,
                 division_number: 225, # division number must be either 1 or 2
                 level: 'A',
                 attachment: fixture_file_upload('/files/codeforces/C.java', 'text/plain')
             },
             language: @language.name
         }
    assert_template 'codeforces_round_solutions/new', 'unsuccessful upload should redirect back to upload page'
    assert_template({partial: 'shared/_error_messages'}, 'unsuccessful upload should display errors')
    assert_empty flash

    # Incorrect language
    post codeforces_round_solutions_path,
         {
             codeforces_round_solution: {
                 round_number: 115,
                 division_number: 1,
                 level: 'A',
                 attachment: fixture_file_upload('/files/codeforces/C.java', 'text/plain')
             },
             language: 'hello'
         }
    assert_not_nil flash[:danger]
    assert_redirected_to new_codeforces_round_solution_path

    # Successful upload
    post codeforces_round_solutions_path,
         {
             codeforces_round_solution: {
                 round_number: 115,
                 division_number: 1,
                 level: 'A',
                 attachment: fixture_file_upload('/files/codeforces/C.java', 'text/plain')
             },
             language: @language.name
         }
    solution = assigns[:solution]
    assert_redirected_to codeforces_round_solution_path(solution.id)
    assert_not_nil flash[:success]
  end
end
