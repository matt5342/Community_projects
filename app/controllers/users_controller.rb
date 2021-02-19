class UsersController < ApplicationController
    before_action :get_user, only: [:show]
    before_action :clear_flash, only: [:index, :show, :edit, :new, :back]


    def index
        @users = User.all
    end

    def show 
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

    def edit 
        @user = current_user
    end
    def update
        @user = current_user
        @user.update(user_params)
        UserCommunity.where("user_id=?", @user.id).destroy_all

        community_params["community_ids"].each do |id|
            unless id == ""
                UserCommunity.create(user_id: current_user.id, community_id: id)
            end
        end
        redirect_to user_path(current_user)
    end
    def back_project
        UserProject.create(user_id: current_user.id, project_id: params[:id])
        redirect_to user_path(current_user)
    end
    def join_community
        UserCommunity.create(user_id: current_user.id, community_id: params[:id])
        redirect_to user_path(current_user)
    end
    def back
        @user = current_user

    end
    def back_these
        UserProject.where("user_id=?", current_user.id).destroy_all
        back_params["backed_project_ids"].each do |id|
            unless id == ""
                UserProject.create(user_id: current_user.id, project_id: id)
            end
        end
        redirect_to user_path(current_user)
    end
    def leave_community
        UserCommunity.where(["user_id = ? and community_id = ?", current_user.id, params[:id]]).first.destroy
        flash[:note] = "#{Community.find(params[:id]).name} has been removed from your communities"
        redirect_to user_path(current_user)
    end
    def unback_project
        UserProject.where(["user_id = ? and project_id = ?", current_user.id,  params[:id]]).first.destroy
        flash[:note] = "#{Project.find(params[:id]).name} has been removed from your list!"
        redirect_to user_path(current_user)
    end

    private

    def community_params
        params.require(:user).permit(:community_ids => [])
    end
    def back_params 
        params.require(:user).permit(:backed_project_ids => [])
    end
    def user_params
        params.require(:user).permit(:user_name, :password, :password_confirmation)
    end
    def get_user
        @user = User.find_by(id: params[:id])
    end
end
