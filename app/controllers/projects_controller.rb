class ProjectsController < ApplicationController
  before_filter :get_project, only: [:show, :edit, :update, :destroy]

  respond_to :js

  def index
    @projects = Project.with_task.all
    @task = Task.new
    respond_to :html, :js
  end

  def show
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(params[:project])
    @project.save
  end

  def update
    @project.update_attributes(params[:project])
  end

  def destroy
    @project.destroy
  end

  private

  def get_project
    @project = Project.find(params[:id])
  end

end
