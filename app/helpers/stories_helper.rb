module StoriesHelper

  def push_user_dropdown_options(users, story)
    story_pushes = story.pushes.where(:user_id => current_user)

    pushed_users = []
    story_pushes.each do |push|
      pushed_users << User.find(push.pushed_user_id)
    end

    users_to_push = users - [current_user]
    users_to_push = users_to_push - pushed_users
    options_from_collection_for_select(users_to_push, :id, :username)
  end

  def user_can_pull(story)
    story.pushes.where(:user_id => current_user, :pushed_user_id => current_user.id).any? || story.users_needed <= story.pushes.where(:user_id => current_user).count
  end

end
