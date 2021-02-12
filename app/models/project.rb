class Project < ApplicationRecord
  belongs_to :user
  has_many :user_projects
  has_many :users, through: :user_projects
  has_many :project_communities
  has_many :communities, through: :project_communities
  validates_presence_of :name, {message: "must have a title!"}
  validates :name, uniqueness: {message: "has already been created!"}
  validates :description, length: {minimum: 5, message: "must be longer than 5 characters!"}
  validates :goal, inclusion: {in: 3..5, message: "must be 3 to 5!"}
  
end
