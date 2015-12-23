require 'test_helper'

# I am including it so that I can use 'fixture_file_upload'
# If there is a way to upload a file with just ActionDispatch::IntegrationTest
# Please feel free to remove 'ActionDispatch::TestProcess' and use that approach
include ActionDispatch::TestProcess

class CodeforcesEditTest < ActionDispatch::IntegrationTest

  def setup
    @member = users(:Taejung)
    @language = languages(:Java)
  end

  test 'edit an uploaded solution' do

    # login as someone who can upload
    log_in_as @member

    # upload a solution first
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

    # There should be only one solution. Let's edit it
    solution = CodeforcesRoundSolution.all.first
    get edit_codeforces_round_solution_path(solution.id)

    assert_template('codeforces_round_solutions/edit')

    # Site should contain proper links
    assert_select 'a[href=?]', codeforces_round_solutions_path
    assert_select 'a[href=?]', codeforces_round_solution_path(solution.id)

    # Send edit request
    new_round_number = 999
    patch codeforces_round_solution_path(solution),
         {
             codeforces_round_solution: {
                 round_number: new_round_number,
                 division_number: solution.division_number,
                 level: solution.level
             },
             language: solution.language.name
         }

    # Check that solution has been properly updated
    solution.reload
    assert_equal new_round_number, solution.round_number

    # We should be directed back to edit with success message
    assert_template('codeforces_round_solutions/edit')
    assert_not_nil flash[:success]
  end

end
