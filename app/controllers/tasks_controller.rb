class TasksController < ApplicationController
  respond_to :js

  before_filter :get_project
  before_filter :get_task, only: [:show, :edit, :update, :destroy]

  def show
  end

  def edit
  end

  def create
    default_task = {priority: 0}
    @task = @project.task.build(default_task.merge(params[:task]))
    @task.save
  end

  def update
    @task.update_attributes(params[:task])
  end

  def destroy
    @task.destroy
  end



  private

  def get_task
    @task = @project.task.find(params[:id])
  end

  def get_project
    @project = Project.find_by_id(params[:project_id])
  end

end