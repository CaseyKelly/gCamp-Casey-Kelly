class User < ActiveRecord::Base
  has_secure_password
  validates :first_name, :last_name, :password, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :memberships, dependent: :destroy
  has_many :projects, through: :memberships

  has_many :comments
  has_many :tasks, through: :comments

  def full_name
    "#{first_name} #{last_name}"
  end

  def project_owner?(project)
    project.memberships.find_by(role: Membership.roles[:owner], user_id: id)
  end

  def project_member?(project)
    project.memberships.find_by(role: Membership.roles[:member], user_id: id)
  end
end
