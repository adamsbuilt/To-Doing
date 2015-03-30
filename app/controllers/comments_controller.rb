class CommentsController < ApplicationController
  before_action :find_set_task

  def index
    @comments = @task.comments.all
    @comment = @task.comment.new
  end

  def create
    @comment = @task.comments.new(comment_params)
    if @comment.save
      flash[:notice] = "Comment Noted"
      redirect_to project_task_path(@task.project.id, @task)
    else
      redirect_to project_task_path(@task.project.id, @task)
    end
  end

  private

  def find_set_task
    @task = Task.find(params[:task_id])
  end

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end

end
