class Story < ActiveRecord::Base

  # -- validations ----------------------------------------------------------

  validates :description, :presence => true

  # -- relationships --------------------------------------------------------

  has_many :tasks, :dependent => :destroy
  has_many :user_stories, :dependent => :destroy
  has_many :users, :through => :user_stories

  # -- callbacks ------------------------------------------------------------


end
