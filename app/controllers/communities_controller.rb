class CommunitiesController < ApplicationController
    before_action :get_id, only: [:show, :edit, :update]
    def index
        @communities = Community.all
    end

    def show
    end
    def edit
        render :edit
    end
    def update
        ProjectCommunity.where("community_id=?", @community.id).destroy_all
        @community.update(community_params)
        make_community(@community)
        project_params["project_id"].each do |id|
            unless id == ""
                ProjectCommunity.create(project_id: id, community_id: @community.id)
            end
        end
        
    end

    def new
        @community = Community.new
    end

    def create
        @community = Community.new(community_params)
        make_community(@community)
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
        params.require(:project).permit(:project_id => [])
    end

end
