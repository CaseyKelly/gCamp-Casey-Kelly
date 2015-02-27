class Task < ActiveRecord::Base
  validates :description, :due_date, presence: true

  belongs_to :project

  def date
    due_date.to_s.gsub("-", "/")
  end
end
