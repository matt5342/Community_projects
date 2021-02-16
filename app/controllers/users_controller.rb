class UsersController < ApplicationController
    before_action :get_user, only: [:show]
    after_action :new_back_project, only: [:back_project]

    def index
        @users = User.all
    end

    def show 
        flash[:user] = @user.id
    end

    private

    def get_user
        @user = User.find_by(id: params[:id])
    end
end
