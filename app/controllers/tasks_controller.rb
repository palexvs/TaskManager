class TasksController < ApplicationController
  include SessionsHelper

  respond_to :js

  before_filter :get_project
  before_filter :get_task, only: [:show, :edit, :update, :destroy, :set_status]

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
    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @task.errors, status: :unprocessable_entity }
        format.js
      end
    end    
  end

  def destroy
    @task.destroy
  end

  private

  def get_task
    @task = @project.task.find(params[:id])
    if @task.nil?
      redirect_to projects_path, alert: "Can't get task"
    end
  end

  def get_project
    @project = current_user.project.find_by_id(params[:project_id])
    if @project.nil?
      redirect_to projects_path, alert: "Can't get project"
    end
  end

end