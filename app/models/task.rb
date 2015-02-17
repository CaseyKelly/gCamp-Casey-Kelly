class Task < ActiveRecord::Base
  validates :description, presence: true

  def date
    due_date.to_s.gsub("-", "/")
  end
end
