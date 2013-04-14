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

  def test_push
    story = stories(:one)
    user = users(:one)
    story.users << user
    user.save
    user_story = story.user_stories.where(:user_id => user).first

    assert_equal 0, user_story.distance

    story.push(user)
    user_story.reload
    assert_equal 1, user_story.distance
  end

end
