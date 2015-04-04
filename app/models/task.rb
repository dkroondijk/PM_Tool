class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates :title, presence: true

  after_initialize :set_defaults

  def set_defaults
    self.status ||= false
  end
end
