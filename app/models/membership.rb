class Membership < ActiveRecord::Base
  validates :user_id, presence: true
  belongs_to :user
  belongs_to :project
  enum role: {member: 0, owner: 1}

  def self.capital_roles
    roles.map{|name, value| [name.capitalize, name]}
  end

end
