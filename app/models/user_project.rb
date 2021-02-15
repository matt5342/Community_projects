class UserProject < ApplicationRecord
  belongs_to :user
  belongs_to :project
  validates :project_id, uniqueness: {scope: :user_id}
  after_save :increment_progress

  def increment_progress
    if self.project.users.count > 0
      self.project.status = "In Progress"  
    else self.project.users.count >= self.goal
      self.project.status = "Completed"
    end
    self.project.save
  end
end
