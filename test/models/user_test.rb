require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = users(:Seulgi)
  end

  test 'deleting user should delete topcoder srm solutions' do
    num_solutions = 5

    num_solutions.times do
      TopCoderSrmSolution.new_with_relations({srm_number: 1, division_number: 1, difficulty: 'easy'}, @user, languages(:cpp)).save!
    end

    assert_equal num_solutions, TopCoderSrmSolution.count

    @user.destroy
    assert_equal 0, TopCoderSrmSolution.count, 'Deleting user should delete its Topcoder srm solutions as well'
  end

  test 'deleting user should delete codeforces round solutions' do
    num_solutions = 5
    num_solutions.times do
      CodeforcesRoundSolution.new_with_relations({round_number: 1, division_number: 1, level: 'A'}, @user, languages(:Java)).save!
    end

    assert_equal num_solutions, CodeforcesRoundSolution.count

    @user.destroy
    assert_equal 0, CodeforcesRoundSolution.count, 'Deleting user should delete its Codeforces round solutions as well'
  end

  test 'authenticated? should return false for a user with nil digest' do
    assert_not @user.authenticated?(:remember, '')
  end

end
