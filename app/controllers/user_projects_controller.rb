class UserProjectsController < ApplicationController

    def index
        @user_projects = UserProject.all
    end
    def new
        # byebug
        @user_project = UserProject.new(user_id: current_user.id)
    end

    def create
        back_project_params["project_id"].each do |id|
            unless id == ""
                UserProject.create(user_id: current_user.id, project_id: id)
            end
        end
        redirect_to user_path(current_user)
    end

    private

    # def user_params
    #     params.require(:user_project).permit(:user_id)
    # end
    def back_project_params
        params.require(:project).permit(:project_id => [])
    end
end