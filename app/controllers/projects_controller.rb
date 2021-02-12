class ProjectsController < ApplicationController
    def index
        @projects = Project.all
    end
    def show
        @project = Project.find(params[:id])
    end
    def new
        @project = Project.new
    end
    def create
        @project = Project.create(project_params)
        if @project.valid?
            redirect_to "/projects"
        else
            flash[:my_errors] = @project.errors.full_messages
            redirect_to "/projects/new"
        end
    end



    private

    def project_params
        params.require(:project).permit(:name, :description, :goal, :user_id, :status => "Started")
    end

end
