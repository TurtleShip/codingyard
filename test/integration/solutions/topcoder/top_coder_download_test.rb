require 'test_helper'

# I am including it so that I can use 'fixture_file_upload'
# If there is a way to upload a file with just ActionDispatch::IntegrationTest
# Please feel free to remove 'ActionDispatch::TestProcess' and use that approach
include ActionDispatch::TestProcess

class TopCoderDownloadTest < ActionDispatch::IntegrationTest

  def setup
    @member = users(:Taejung)
    @language = languages(:Java)
  end

  test 'full download' do
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

    solution = assigns[:solution]

    # Check that show page contains a link to download the solution
    get top_coder_srm_solution_path(solution)
    assert_select 'a[href=?]', download_top_coder_srm_solution_path(solution)

    # Now download it
    get download_top_coder_srm_solution_path(solution)
    downloaded_content = response.body
    original_content = fixture_file_upload('/files/codeforces/C.java', 'text/plain').read

    assert_equal original_content, downloaded_content, 'downloaded content should match the original content'
  end

end
