require 'test_helper'

class ContestTest < ActiveSupport::TestCase

  def setup
    @contest = contests(:TopCoder)
  end

  test 'an example contest should be valid' do
    assert @contest.valid?
  end

  test 'Name cannot be nil or empty' do
    @contest.name = nil
    assert_not @contest.valid?

    @contest.name = ''
    assert_not @contest.valid?

    @contest.name = '        '
    assert_not @contest.valid?
  end

  test 'description can be skipped' do
    @contest.description = nil
    assert @contest.valid?
  end

  test 'valid urls should be accepted' do
    valid_urls = ['http://www.solve.org', 'https://www.chllaenge.io/tc', 'https://uhunt.felix-halim.net']
    valid_urls.each do |url|
      @contest.url = url
      assert @contest.valid?, "#{url} should be valid"
    end
  end

  test 'invalid urls should be rejected' do
    invalid_urls = ['yolo.com, http://internal', 'localhost:8080']
    invalid_urls.each do |url|
      @contest.url = url
      assert_not @contest.valid?, "#{url} should be invalid"
    end
  end

  test 'deleting a contest should delete its topcoder srm solutions' do
    num_solutions = 5
    user = users(:Seulgi)
    top_coder = contests(:TopCoder)

    num_solutions.times do
      user.top_coder_srm_solutions.create(contest_id: top_coder.id, srm_number: 1, division_number: 1, difficulty: 'easy')
    end

    assert_equal num_solutions, TopCoderSrmSolution.count

    top_coder.destroy
    assert_equal 0, TopCoderSrmSolution.count, 'Deleting user should delete its TopCoder SRM solutions as well'
  end

  test 'deleting a contest should delete its codeforces round solutions' do
    num_solutions = 5
    user = users(:Seulgi)


    num_solutions.times do
      CodeforcesRoundSolution.new_with_relations({round_number: 1, division_number: 1, level: 'A'},
                                                  user, languages(:Java)).save!
    end

    assert_equal num_solutions, CodeforcesRoundSolution.count

    Contest.codeforces.destroy
    assert_equal 0, CodeforcesRoundSolution.count, 'Deleting user should delete its Codeforces round solutions as well'
  end

end
