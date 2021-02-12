class ProjectCommunity < ApplicationRecord
  belongs_to :community
  belongs_to :project
  validates :project_id, uniqueness: {scope: :community_id}
end
