class TasksController < ApplicationController

  before_action :find_task, only: [:update]
  before_action :find_project, only: [:create, :update]

    def create
    @task = current_user.tasks.new(task_params)
    @task.project = @project
    if @task.save
      redirect_to project_path(@project)
    else
      render "/projects/show"
    end
  end

  def update
    if @task.update(task_params)
      redirect_to project_path(@project)
    end
  end

  
  private

  def task_params
    params.require(:task).permit(:title, :due_date, :status)
  end

  def find_project
    @project = Project.find(params[:project_id])
  end

  def find_task
    @task = Task.find(params[:id])
  end

end
