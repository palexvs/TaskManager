class ProjectsController < ApplicationController
  before_filter :loged_in
  before_filter :get_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = current_user.project.with_task.all
    @task = Task.new
    respond_to do |format|
      format.html { render partial: 'projects', collection: @projects, as: :project }
    end
  end

  def new
    @project = Project.new
    render partial: 'project'
  end

  def edit
    render partial: 'project'
  end

  def create
    @project = current_user.project.build(params[:project])
    respond_to do |format|
      if @project.save
          format.json { head :no_content }
        else
          format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update_attributes(params[:project])
          format.json { head :no_content }
        else
          format.json { render json: @project.errors, status: :unprocessable_entity }
      end    
    end    
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

  def get_project
    @project = current_user.project.find_by_id(params[:id])
    if @project.nil?
      redirect_to projects_path, alert: "Can't get project"
    end
  end

end
