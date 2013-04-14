require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def test_callback_add_all_stories
    user = User.create({
      :username => 'some fellow',
      :email => 'somefellow@email.com',
      :password => 'pass',
      :password_confirmation => 'pass'
    })
    assert_equal 2, user.user_stories.count
    assert_equal 2, user.stories.count
    assert_equal stories(:one), user.stories.last
    assert_equal stories(:two), user.stories.first
  end

  def test_can_be_pushed
    current_user = users(:one)
    user = users(:two)
    story = stories(:one)

    assert_equal 0, current_user.pushes.where(:story_id => story, :pushed_user_id => user).count

    assert user.can_be_pushed(story, current_user)

    push = current_user.pushes.new(:pushed_user_id => user.id)
    push.story = story
    push.save
    story.reload
    current_user.reload

    assert_equal 1, current_user.pushes.where(:story_id => story, :pushed_user_id => user).count

    assert !user.can_be_pushed(story, current_user)
  end

end
