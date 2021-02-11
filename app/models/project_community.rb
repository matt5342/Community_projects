class ProjectCommunity < ApplicationRecord
  belongs_to :community
  belongs_to :project
end
