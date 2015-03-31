class User < ActiveRecord::Base
  has_secure_password
  validates :first_name, :last_name, :password, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :memberships, dependent: :destroy
  has_many :projects, through: :memberships

  def full_name
    "#{first_name} #{last_name}"
  end
end
