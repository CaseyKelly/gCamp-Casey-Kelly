class Task < ActiveRecord::Base
  validates :description, :due_date, presence: true

  belongs_to :project

  has_many :comments, dependent: :destroy
  has_many :users, through: :comments

  def date
    due_date.to_s.gsub("-", "/")
  end
end
