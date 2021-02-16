class UsersController < ApplicationController
    before_action :get_user, only: [:show]
    # after_action :new_back_project, only: [:back_project]

    def index
        @users = User.all
    end

    def show 
        flash[:user] = @user.id
    end
    def new
        @user = User.new
    end
    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_url, notice: "Thank you for signing up!"
        else
            flash[:errors] = @user.errors.full_messages
            render new_user_path
        end
    end

    def back_project
        # byebug

        UserProject.create(user_id: current_user.id, project_id: params[:id])
        redirect_to user_path(current_user)
    end

    private

    def user_params
        params.require(:user).permit(:user_name, :password, :password_confirmation)
    end
    def get_user
        @user = User.find_by(id: params[:id])
    end
end
