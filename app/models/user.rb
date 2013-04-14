class User < ActiveRecord::Base
  authenticates_with_sorcery!

  # -- validations ----------------------------------------------------------

  validates :password, 
    :presence => true,
    :confirmation => true

  # -- relationships --------------------------------------------------------

  has_many :user_stories, :dependent => :destroy
  has_many :stories, :through => :user_stories
  has_many :pushes

  # -- callbacks ------------------------------------------------------------

  after_create :add_all_stories

  # -- instance methods -----------------------------------------------------

  def can_be_pushed(story, current_user)
    current_user.pushes.where(:story_id => story, :pushed_user_id => self.id).empty?
  end

  private

  def add_all_stories
    Story.all.each do |story|
      unless self.stories.include? story
        self.stories << story
        self.save
      end
    end
  end

end
