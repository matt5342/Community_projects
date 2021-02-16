class ProjectsController < ApplicationController
    before_action :get_project, only: [:show, :destroy, :edit, :update]
    def index
        # byebug
        @status = ["Started", "In Progress", "Completed"]
        if @status.include?(params[:status])
            flash[:status] = params[:status]
            @projects = Project.select{|p| p.status == params[:status]}
        else
            flash[:status] = "All"
            @projects = Project.all
        end
    end
    def show
    end
    def edit
        render :new
    end
    def update
        ProjectCommunity.where("project_id=?", @project.id).destroy_all
        @project.update(project_params)
        make_project(@project)
    end

    def new
        @project = Project.new(user_id: flash[:user])
    end
    def create

        @project = Project.create(project_params)
        make_project(@project)
    end
    def destroy
        @project.destroy
        redirect_to projects_path
    end





    private

        def make_project(project)
        community_params["community_id"].each do |id|
            unless id == ""
                ProjectCommunity.create(community_id: id, project_id: @project.id)
            end
        end
        if @project.valid?
            redirect_to "/projects"
        else
            flash[:my_errors] = @project.errors.full_messages
            redirect_to "/projects/new"
        end
    end

    def get_project
        @project = Project.find(params[:id])
    end
    def project_params
        params.require(:project).permit(
            :name, :description, :goal, :user_id, :status
        )
    end
    def community_params
        params.require(:community).permit(:community_id => [])
    end

end
