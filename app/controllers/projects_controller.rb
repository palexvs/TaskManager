class ProjectsController < ApplicationController
  include SessionsHelper

  before_filter :loged_in
  before_filter :get_project, only: [:show, :edit, :update, :destroy]

  respond_to :js

  def index
    @projects = current_user.project.with_task.all
    @task = Task.new
  end

  def show
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = current_user.project.build(params[:project])
    @project.save
  end

  def update
    @project.update_attributes(params[:project])
  end

  def destroy
    respond_to do |format|
      if @project.destroy
          format.json { head :no_content }
        else
          format.json { render json: @project.errors, status: :unprocessable_entity }
      end    
    end
  end  

  private

  def loged_in
      redirect_to login_path if !signed_in?
  end

  def get_project
    @project = current_user.project.find_by_id(params[:id])
    if @project.nil?
      redirect_to projects_path, alert: "Can't get project"
    end
  end

end
