require 'test_helper'

class TopCoderSrmSolutionTest < ActiveSupport::TestCase

  def setup
    @user = users(:Seulgi)
    @contest = contests(:TopCoder)
    @solution = @user.top_coder_srm_solutions.create(contest_id: @contest.id,
                                                     srm_number: 256, division_number: 1, save_path: '/topcoder/256/div1/mid.cpp')

  end

  test 'an example solution must be valid' do
    assert @solution.valid?
    assert @user.save
    assert @contest.save
    assert @solution.save
  end

  test 'srm solution must have a user id' do
    @solution.user_id = nil
    assert_not @solution.valid?
  end

  test 'srm solution must have a contest id' do
    @solution.contest_id = nil
    assert_not @solution.valid?
  end


end
