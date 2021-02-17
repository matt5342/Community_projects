class User < ApplicationRecord
    has_secure_password
    has_many :projects
    has_many :user_projects
    has_many :backed_projects, through: :user_projects, :source => :project
    has_many :user_communities
    has_many :communities, through: :user_communities
    validates :user_name, uniqueness: {message: "has already been created! Pick a new username."}
    validate :pass_valid?

    attr_reader :password, :password_confirmation

    def pass_valid?
        unless password == password_confirmation && password.length > 6
            errors.add(:password, "must be longer than 6 letters")
        end
    end
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
