class CommentsController < ApplicationController
  def create
    @task = Task.find(params[:task_id])
    @comment = Comment.new(comment_params)
    @comment.task_id = params[:task_id]
    @comment.user_id = current_user.id
    @project = @comment.task.project
      if @comment.save
        redirect_to project_task_path(@project, @task), notice: 'Comment was successfully created.'
      else
        render :new
      end
  end

  private

  def comment_params
    params.require(:comment).permit(:message, :user_id, :task_id)
  end
end
