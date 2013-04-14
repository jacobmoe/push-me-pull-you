class User < ActiveRecord::Base
  authenticates_with_sorcery!

  # -- validations ----------------------------------------------------------

  validates :password, 
    :presence => true,
    :confirmation => true

  # -- relationships --------------------------------------------------------

  has_many :user_stories, :dependent => :destroy
  has_many :stories, :through => :user_stories

  # -- callbacks ------------------------------------------------------------

  after_create :add_all_stories

  # -- instance methods -----------------------------------------------------

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
