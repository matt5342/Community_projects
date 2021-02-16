class Community < ApplicationRecord
    has_many :user_communities
    has_many :users, through: :user_communities
    has_many :project_communities, dependent: :destroy
    has_many :projects, through: :project_communities
    validates :name, uniqueness: {message: "has already been created!"}
    validates :name, presence: {message: "must have a name!"}
end
