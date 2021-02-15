class UsersController < ApplicationController
    before_action :get_user, only: [:show, :new_back_project]
    after_action :new_back_project, only: [:back_project]

    def index
        @users = User.all
    end

    def show 
        flash[:user] = @user.id
    end

    def new_back_project
        @user_project = UserProject.new
        # back_project_params["project_id"].each do |id|
        #     unless id == ""
        #         UserProject.create(user_id: @user.id, project_id: id)
        #     end
        # end
    end

    def back_project
        # get_user
        byebug
        back_project_params["project_id"].each do |id|
            unless id == ""
                UserProject.create(user_id: @user.id, project_id: id)
            end
        end

    end

    private

    def get_user
        @user = User.find_by(id: params[:id])
    end
    def user_params
        params.require(:user).permit(:id)
    end

    def back_project_params
        params.require(:user_project).permit(:project_id => [])
    end
end
