class ProjectsController < ApplicationController
    before_action :get_project, only: [:show, :destroy, :edit, :update]
    before_action :authorize, only: [:index]
    def index
        # byebug
        @status = ["Started", "In Progress", "Completed"]
        if @status.include?(params[:status])
            flash[:status] = params[:status]
            @projects = Project.select{|p| p.status == params[:status]}
            if @projects.size == 0
                @message = "No projects #{params[:status]} yet, back some projects!"
            end
        else
            flash[:status] = "All"
            @projects = Project.all
        end

    end
    def show
        flash[:status] = nil
        # flash[:user] = nil
    end
    def edit
        flash[:status] = nil
        if current_user.id != @project.user_id
            redirect_to project_path(@project), alert: "Only the creator can edit this project" 
        else
            render :new
        end
    end
    def update
        if current_user.id != @project.user_id
            redirect_to project_path(@project), alert: "Only the creator can edit this project" 
        else
            ProjectCommunity.where("project_id=?", @project.id).destroy_all
            @project.update(project_params)
            make_project(@project)
        end
    end

    def new
        flash[:status] = nil
        # flash[:user] = nil
        @project = Project.new(user_id: flash[:user])
    end
    def create

        @project = Project.create(project_params)
        make_project(@project)
    end
    def destroy
        if current_user.id != @project.user_id
            redirect_to project_path(@project), alert: "Only the creator can delete this project" 
        else
            @project.destroy
            redirect_to projects_path
        end
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
            flash[:errors] = @project.errors.full_messages
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
