class ProjectsController < ApplicationController

  def index
    @projects = Project.all
    render :index
  end

  def new
    @project = Project.new
    render :new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to projects_path
    else 
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
    render :edit
  end

  def show
    @project = Project.find(params[:id])
    @proj_emp = @project.employees
    render :show
  end

  def update
    @project = Project.find(params[:id])
    @employee = Employee.find(params[:project][:id])
    @project.employees << @employee
    if @project.update(project_params)
      flash[:notice] = "Project Updated"
      redirect_to projects_path
    else
      render :edit  
    end
  end

  def destroy
   @project = Project.find(params[:id])
   @project.destroy
   flash[:notice] = "Project Deleted"
   redirect_to projects_path
  end

  private
    def project_params
      params.require(:project).permit(:title)
    end
end