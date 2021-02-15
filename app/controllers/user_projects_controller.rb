class UserProjectsController < ApplicationController

    def index
        @user_projects = UserProject.all
    end
    def new
        @user_project = UserProject.new(user_id: flash[:user])
    end

    def create
        back_project_params["project_id"].each do |id|
            unless id == ""
                UserProject.create(user_id: user_params[:user_id], project_id: id)
            end
        end
        redirect_to user_path(user_params[:user_id])
    end

    private

    def user_params
        params.require(:user_project).permit(:user_id)
    end
    def back_project_params
        params.require(:project).permit(:project_id => [])
    end
end