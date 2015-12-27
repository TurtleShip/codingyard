require 'test_helper'

class UvaSolutionTest < ActiveSupport::TestCase

  def setup
    @user = users(:Seulgi)
    language = languages(:Java)
    params = {problem_number: 123, original_link: 'http://www.codingyard.com/yolo'}
    @solution = UvaSolution.new_with_relations(params, @user, language)
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

  test 'a solution should have a positive problem number' do
    @solution.problem_number = nil
    assert_not @solution.valid?

    @solution.problem_number = -1
    assert_not @solution.valid?

    @solution.problem_number = 0
    assert_not @solution.valid?

    @solution.problem_number = 1
    assert @solution.valid?
  end

end
