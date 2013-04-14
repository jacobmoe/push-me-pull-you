class Story < ActiveRecord::Base

  # -- validations ----------------------------------------------------------

  validates :description, :presence => true
  validates :users_needed, :presence => true

  # -- relationships --------------------------------------------------------

  has_many :tasks, :dependent => :destroy
  has_many :user_stories, :dependent => :destroy
  has_many :users, :through => :user_stories
  has_many :pushes, :dependent => :destroy

  # -- callbacks ------------------------------------------------------------

  after_create :add_all_users

  # -- instance_methods -----------------------------------------------------

  def push(user)
    user_story = self.user_stories.where(:user_id => user).first
    user_story.distance += 1
    user_story.save
  end

  def has_pushes_left(current_user)
    current_user.pushes.where(:story_id => self).count < self.users_needed
  end

  private

  def add_all_users
    User.all.each do |user|
      unless self.users.include? user
        self.users << user
        self.save
      end
    end

  end

end
