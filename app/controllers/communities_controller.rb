class CommunitiesController < ApplicationController
    before_action :get_id, only: [:show]
    def index
        @communities = Community.all
    end

    def show
    end

    def new
        @community = Community.new
    end

    def create
        @community = Community.new(community_params)
        if @community.valid?
            @community.save
            redirect_to @community
        else
            flash[:errors] = @community.errors.full_messages
            redirect_to new_community_path
        end
    end

private
    def get_id
        @community = Community.find_by(id: params[:id])
    end

    def community_params
        params.require(:community).permit(:name)
    end

end
