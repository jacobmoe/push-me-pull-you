class Story < ActiveRecord::Base

  # -- validations ----------------------------------------------------------

  validates :description, :presence => true

  # -- relationships --------------------------------------------------------

  has_many :tasks, :dependent => :destroy
  has_many :user_stories, :dependent => :destroy
  has_many :users, :through => :user_stories

  # -- callbacks ------------------------------------------------------------

  after_create :add_all_users

  # -- instance_methods -----------------------------------------------------

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
