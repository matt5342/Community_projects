class ProjectsController < ApplicationController
    def index
        # byebug
        @status = ["Started", "In Progress", "Completed"]
        if @status.include?(params[:status])
            flash[:status] = params[:status]
            # byebug
            @projects = Project.select{|p| p.status == params[:status]}
        else
            flash[:status] = "All"
            @projects = Project.all
        end
    end
    def show
        @project = Project.find(params[:id])
    end
    def new
        @project = Project.new(user_id: flash[:user])
    end
    def create
        byebug
        @project = Project.create(project_params)
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




    private

    def project_params
        params.require(:project).permit(
            :name, :description, :goal, :user_id, :status
        )
    end
    def community_params
        params.require(:community).permit(:community_id => [])
    end

end
