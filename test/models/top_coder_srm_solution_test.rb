require 'test_helper'

class TopCoderSrmSolutionTest < ActiveSupport::TestCase

  def setup
    @user = users(:Seulgi)
    @contest = contests(:TopCoder)
    language = languages(:cpp)
    params = {srm_number: 256, division_number: 1, difficulty: 'hard'}
    @solution = TopCoderSrmSolution.new_with_relations(params, @user, language)
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

  test 'srm solution should have positive srm number' do
    @solution.srm_number = nil
    assert_not @solution.valid?

    @solution.srm_number = -1
    assert_not @solution.valid?

    @solution.srm_number = 100
    assert @solution.valid?
  end

  test 'srm solution should division number either 1 or 2' do
    @solution.division_number = nil
    assert_not @solution.valid?

    @solution.division_number = -1
    assert_not @solution.valid?

    @solution.division_number = 0
    assert_not @solution.valid?

    @solution.division_number = 3
    assert_not @solution.valid?

    @solution.division_number = 1
    assert @solution.valid?

    @solution.division_number = 2
    assert @solution.valid?
  end

  test 'srm solution should have difficulty in [easy, medium, hard]' do
    @solution.difficulty = nil
    assert_not @solution.valid?

    invalid_difficulties = ['Kinda hard', '']
    invalid_difficulties.each do |difficulty|
      @solution.difficulty = difficulty
      assert_not @solution.valid?, "#{difficulty} should not be valid"
    end

    valid_difficulties = %w(easy medium hard)
    valid_difficulties.each do |difficulty|
      @solution.difficulty = difficulty
      assert @solution.valid?, "#{difficulty} should be valid"
    end
  end

  test 'srm solution difficulty should be downcased before validation' do

    valid_difficulties = %w(EaSy eAsY EASY easy EasY eaSY)
    valid_difficulties.each do |difficulty|
      @solution.difficulty = difficulty
      assert @solution.valid?
      assert @solution.save
      assert_equal 'easy', @solution.difficulty
    end
  end

end
