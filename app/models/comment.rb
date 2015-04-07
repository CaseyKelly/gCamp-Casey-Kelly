class Comment < ActiveRecord::Base
  validates :message, presence: true

  belongs_to :task
  belongs_to :user
end
