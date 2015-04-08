task cleanup: [:environment] do
  desc 'clean database'
  Membership.all.each do |membership|
    membership.destroy if membership.user_id.nil? or membership.project_id.nil?
  end
  Comment.where(task_id: nil).destroy_all
  Task.where(project_id: nil).destroy_all
end
