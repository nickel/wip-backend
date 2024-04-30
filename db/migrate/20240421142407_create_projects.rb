class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.string :project_type, null: false
      t.string :reference_url

      t.timestamps
    end
  end
end
