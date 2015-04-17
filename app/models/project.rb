class Project < ActiveRecord::Base
  belongs_to :user
  has_many :tasks, dependent: :destroy
  has_many :discussions, dependent: :destroy

  has_many :members, dependent: :destroy
  has_many :member_users, through: :members, source: :user 

  validates :title, presence: true
end
