class UserStory < ActiveRecord::Base

  # -- relationships --------------------------------------------------------

  belongs_to :story
  belongs_to :user

end
