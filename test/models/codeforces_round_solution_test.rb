require 'test_helper'

class CodeforcesRoundSolutionTest < ActiveSupport::TestCase

  def setup
    @user = users(:Seulgi)
    @codefores = contests(:Codeforces)
    @solution = @user.codeforces_round_solutions.create(contest_id: @codefores.id,
                                                        round_number: 1, division_number: 1, level: 'A')
  end

  test 'am example solution should be valid' do
    assert @solution.valid?
  end

  test 'a solution should have a user id' do
    @solution.user_id = nil
    assert_not @solution.valid?
  end

  test 'a solution should have a contest id' do
    @solution.contest_id = nil
    assert_not @solution.valid?
  end

end
