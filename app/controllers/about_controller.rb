class AboutController < ApplicationController
  def show
    project_num = Project.all.length
    if project_num == 1
      @project_count = "#{project_num} Project"
    else
      @project_count = "#{project_num} Projects"
    end

    task_num = Task.all.length
    if task_num == 1
      @task_count = "#{task_num} Task"
    else
      @task_count = "#{task_num} Tasks"
    end

    member_num = Membership.all.length
    if member_num == 1
      @member_count = "#{member_num} Project Member"
    else
      @member_count = "#{member_num} Project Members"
    end

    user_num = User.all.length
    if user_num == 1
      @user_count = "#{user_num} User"
    else
      @user_count = "#{user_num} Users"
    end

  end
end
