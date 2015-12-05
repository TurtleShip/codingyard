require 'test_helper'

class CodeforcesRoundSolutionTest < ActiveSupport::TestCase

  def setup
    @user = users(:Seulgi)
    language = languages(:Java)
    params = {round_number: 1, division_number: 1, level: 'A'}
    @solution = CodeforcesRoundSolution.new_with_relations!(params, @user, language)
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

  test 'a solution should be a positive round number' do
    @solution.round_number = nil
    assert_not @solution.valid?

    @solution.round_number = -1
    assert_not @solution.valid?

    @solution.round_number = 0
    assert_not @solution.valid?

    @solution.round_number = 1
    assert @solution.valid?
  end

  test 'a solution should have a division number of either 1 or 2' do
    invalid_division_numbers = [nil, -1, 0, 3, 5, 9999]
    invalid_division_numbers.each do |division_number|
      @solution.division_number = division_number
      assert_not @solution.valid?
    end

    valid_division_numbers = [1, 2]
    valid_division_numbers.each do |division_number|
      @solution.division_number = division_number
      assert @solution.valid?
    end
  end


  test 'a solution should have a level of A,B,C,D or E' do
    invalid_levels = [nil, '', 'hard', 'easy', '!!@#%']
    invalid_levels.each do |level|
      @solution.level = level
      assert_not @solution.valid?, "#{level} should not be a valid level."
    end

    valid_levels = %w(A B C D E)
    valid_levels.each do |level|
      @solution.level = level
      assert @solution.valid? "#{level} shbould be a valid level."
    end
  end

  test 'level should be upcased before validation' do
    valid_levels = %w(a b c d e)
    valid_levels.each do |level|
      @solution.level = level
      @solution.save
      assert_equal level.upcase, @solution.level
    end
  end

end
