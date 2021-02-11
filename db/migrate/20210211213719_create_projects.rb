class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
