class CommunitiesController < ApplicationController
    before_action :get_id, only: [:show, :edit, :update]
    before_action :authorize, only: [:index]
    before_action :clear_flash, only: [:show, :edit, :new]

    def index
        @communities = Community.all
    end

    def show
    end
    def edit
        @community = Community.find(params[:id])
        if !@community.users.include?current_user
            flash[:note] = "Only members can edit this community"
            redirect_to @community
        end
        #render :edit
    end
    def update
        ProjectCommunity.where("community_id=?", @community.id).destroy_all
        project_params["project_ids"].each do |id|
            unless id == ""
                ProjectCommunity.create(project_id: id, community_id: @community.id)
            end
        end
        redirect_to @community
    end

    def new
        @community = Community.new
    end

    def create
        @community = Community.new(community_params)
        make_community(@community)
        UserCommunity.create(user_id: current_user.id, community_id: @community.id)
        project_params["project_ids"].each do |id|
            unless id == ""
                ProjectCommunity.create(project_id: id, community_id: @community.id)
            end
        end
    end

private
    def make_community(community)
        if @community.valid?
            @community.save
            redirect_to @community
        else
            flash[:errors] = @community.errors.full_messages
            redirect_to new_community_path
        end
    end

    def get_id
        @community = Community.find_by(id: params[:id])
    end

    def community_params
        params.require(:community).permit(:name)
    end
    def project_params
        params.require(:community).permit(:project_ids => [])
    end

end
