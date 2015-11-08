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

end
