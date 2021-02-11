class CreateProjectCommunities < ActiveRecord::Migration[6.1]
  def change
    create_table :project_communities do |t|
      t.references :community, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
