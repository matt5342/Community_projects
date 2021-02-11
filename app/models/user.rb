class User < ApplicationRecord
    has_many :projects
    has_many :user_projects
    has_many :backed_projects, through: :user_projects, :source => :project
    has_many :user_communities
    has_many :communities, through: :user_communities

# def backed_projects
#     UserProject.all.select{
#         |up|
#         up.user_id == self.id
#     }.collect{
#         |up|
#         up.project
#     }
# end
    
end
