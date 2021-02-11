class Project < ApplicationRecord
  belongs_to :user
  has_many :user_projects
  has_many :users, through: :user_projects
  has_many :project_communities
  has_many :communities, through: :project_communities
  
end
