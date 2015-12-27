require 'test_helper'

# I am including it so that I can use 'fixture_file_upload'
# If there is a way to upload a file with just ActionDispatch::IntegrationTest
# Please feel free to remove 'ActionDispatch::TestProcess' and use that approach
include ActionDispatch::TestProcess

class UvaEditTest < ActionDispatch::IntegrationTest

  def setup
    @member = users(:Taejung)
    @language = languages(:Java)
  end

  test 'edit an uploaded solution' do

    # login as someone who can upload
    log_in_as @member

    # upload a solution first
    post uva_solutions_path,
         {
             uva_solution: {
                 problem_number: 115,
                 attachment: fixture_file_upload('/files/codeforces/C.java', 'text/plain')
             },
             language: @language.name
         }

    # There should be only one solution. Let's edit it
    solution = UvaSolution.all.first
    get edit_uva_solution_path(solution.id)

    assert_template('uva_solutions/edit')

    # Site should contain proper links
    assert_select 'a[href=?]', uva_solutions_path
    assert_select 'a[href=?]', uva_solution_path(solution.id)

    # Send edit request
    new_problem_number = 999
    problem_link = 'http://codingyard.com/good-prob'
    title = 'Beautiful world!'
    patch uva_solution_path(solution),
          {
              uva_solution: {
                  problem_number: new_problem_number,
                  original_link: problem_link,
                  title: title
              },
              language: solution.language.name

          }

    # Check that solution has been properly updated
    solution.reload
    assert_equal new_problem_number, solution.problem_number
    assert_equal problem_link, solution.original_link
    assert_equal title, solution.title

    # We should be directed back to edit with success message
    assert_template('uva_solutions/edit')
    assert_not_nil flash[:success]
  end

end
