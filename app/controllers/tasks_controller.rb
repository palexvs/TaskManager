class TasksController < ApplicationController
  include SessionsHelper

  respond_to :js

  before_filter :loged_in
  before_filter :get_project
  before_filter :get_task, only: [:show, :edit, :update, :destroy, :set_status, :change_priority]

  def show
    respond_to do |format|
      format.html { render partial: 'task' }
    end
  end

  def edit
    respond_to do |format|
      format.html { render partial: 'edit' }
    end    
  end

  def create
    @task = @project.task.build(params[:task])
    respond_to do |format|
      if @task.save
          format.html { render partial: 'projects/task-row', locals: { task: @task } }
        else
          format.json { render json: @task.errors, status: :unprocessable_entity }
      end    
    end    
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
    respond_to do |format|
      if @task.destroy
          format.json { head :no_content }
        else
          format.json { render json: @task.errors, status: :unprocessable_entity }
      end    
    end
  end  

  def change_priority
    respond_to do |format|
      if @task.change_priority(params[:direction])
          format.json { head :no_content }
        else
          format.json { render json: @task.errors, status: :unprocessable_entity }
      end    
    end
  end

  private

  def loged_in
      redirect_to login_path if !signed_in?
  end  

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