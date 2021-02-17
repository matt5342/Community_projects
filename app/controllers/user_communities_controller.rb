# class UserCommunitiesController < ApplicationController

#     def new
#         # byebug
#         @user = current_user
#         @user_community = UserCommunity.new(user_id: current_user.id)
#     end

#     def create
#         back_project_params["community_ids"].each do |id|
#             unless id == ""
#                 UserCommunity.create(user_id: current_user.id, community_id: id)
#             end
#         end
#         redirect_to user_path(current_user)
#     end

#     private

#     # def user_params
#     #     params.require(:user_project).permit(:user_id)
#     # end
#     def back_project_params
#         params.require(:user).permit(:community_ids => [])
#     end
# end