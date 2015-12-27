require 'test_helper'

# I am including it so that I can use 'fixture_file_upload'
# If there is a way to upload a file with just ActionDispatch::IntegrationTest
# Please feel free to remove 'ActionDispatch::TestProcess' and use that approach
include ActionDispatch::TestProcess

class TopCoderEditTest < ActionDispatch::IntegrationTest

  def setup
    @member = users(:Taejung)
    @language = languages(:Java)
  end

  test 'edit an uploaded solution' do

    # login as someone who can upload
    log_in_as @member

    # upload a solution first
    post top_coder_srm_solutions_path,
         {
             top_coder_srm_solution: {
                 srm_number: 115,
                 division_number: 1,
                 difficulty: 'easy',
                 attachment: fixture_file_upload('/files/codeforces/C.java', 'text/plain')
             },
             language: @language.name
         }

    # There should be only one solution. Let's edit it
    solution = TopCoderSrmSolution.all.first
    get edit_top_coder_srm_solution_path(solution.id)

    assert_template('top_coder_srm_solutions/edit')

    # Site should contain proper links
    assert_select 'a[href=?]', top_coder_srm_solutions_path
    assert_select 'a[href=?]', top_coder_srm_solution_path(solution.id)

    # Send edit request
    srm_number = 999
    division_number = 2
    difficulty = 'hard'
    original_link = 'http://codingyard.com/good-prob'
    patch top_coder_srm_solution_path(solution),
          {
              top_coder_srm_solution: {
                  srm_number: srm_number,
                  division_number: division_number,
                  difficulty: difficulty,
                  original_link: original_link
              },
              language: solution.language.name

          }

    # Check that solution has been properly updated
    solution.reload
    assert_equal srm_number, solution.srm_number
    assert_equal division_number, solution.division_number
    assert_equal difficulty, solution.difficulty
    assert_equal original_link, solution.original_link

    # We should be directed back to edit with success message
    assert_template('top_coder_srm_solutions/edit')
    assert_not_nil flash[:success]
  end

end
