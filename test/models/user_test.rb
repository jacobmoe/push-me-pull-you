require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def test_add_all_stories
    user = users(:one)
    assert_equal 0, user.stories.count
    assert_equal 0, user.user_stories.count
    user.add_all_stories
    assert_equal 2, user.user_stories.count
    assert_equal 2, user.stories.count
    assert_equal stories(:one), user.stories.last
  end

end
