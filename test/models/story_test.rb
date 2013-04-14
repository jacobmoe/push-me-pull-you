require 'test_helper'

class StoryTest < ActiveSupport::TestCase

  def test_callback_add_all_users
    story = Story.create({
      :description => 'a story!'
    })
    assert_equal 2, story.user_stories.count
    assert_equal 2, story.users.count
    assert_equal users(:one), story.users.last
    assert_equal users(:two), story.users.first

  end

end
