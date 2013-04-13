class Task < ActiveRecord::Base

  # -- validations ----------------------------------------------------------

  validates :description, :presence => true

  # -- relationships --------------------------------------------------------
  belongs_to :story

end
