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

end
