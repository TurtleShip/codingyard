require 'test_helper'

class LanguageTest < ActiveSupport::TestCase

  def setup
    @java = languages(:Java)
  end

  test 'An example language should be valid' do
    assert @java.valid?
  end

end
