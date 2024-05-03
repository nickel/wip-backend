class CreateNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :notes do |t|
      t.string :title
      t.text :content
      t.boolean :private, default: true, null: false
      t.string :tags, array: true, default: []

      t.timestamps
    end
  end
end
