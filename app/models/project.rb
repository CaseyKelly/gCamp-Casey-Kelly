class Project < ActiveRecord::Base
  validates :name, presence: true

  has_many :tasks, dependent: :destroy
  
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  def num_memberships
    if self.memberships.length == 1
      "#{self.memberships.length} Membership"
    else
      "#{self.memberships.length} Memberships"
    end
  end

  def num_tasks
    if self.tasks.length == 1
      "#{self.tasks.length} Task"
    else
      "#{self.tasks.length} Tasks"
    end
  end
end
