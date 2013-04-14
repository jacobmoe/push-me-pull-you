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

  def test_has_pushes_left
    current_user = users(:one)
    user = users(:two)
    story = stories(:one)

    assert_equal 1, story.users_needed
    assert_equal 0, current_user.pushes.where(:story_id => story).count

    assert story.has_pushes_left(current_user)

    push = current_user.pushes.new(:pushed_user_id => user.id)
    push.story = story
    push.save
    story.reload
    current_user.reload

    assert_equal 1, current_user.pushes.where(:story_id => story).count

    assert !story.has_pushes_left(current_user)
  end

end
