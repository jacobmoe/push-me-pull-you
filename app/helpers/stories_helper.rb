module StoriesHelper

  def push_user_dropdown_options(users, current_user)
    push_users = users - [current_user]
    options_from_collection_for_select(push_users, :id, :username)
  end

end
