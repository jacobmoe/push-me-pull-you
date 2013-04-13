class Story < ActiveRecord::Base

  # -- Validations ----------------------------------------------------------

  validates :description, :presence => true

  # -- Relationships --------------------------------------------------------

  has_many :tasks

end
