class Project < ActiveRecord::Base
  validates :name, presence: true

  has_many :tasks, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  def num_memberships
    if self.memberships.length == 1
      "#{self.memberships.length} membership"
    else
      "#{self.memberships.length} memberships"
    end
  end

  def num_tasks
    if self.tasks.length == 1
      "#{self.tasks.length} task"
    else
      "#{self.tasks.length} tasks"
    end
  end
end
