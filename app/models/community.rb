class Community < ApplicationRecord
    has_many :user_communities
    has_many :users, through: :user_communities
    has_many :project_communities
    has_many :projects, through: :project_communities
    
end
