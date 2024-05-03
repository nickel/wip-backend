class CreateLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :logs do |t|
      t.text :content

      t.timestamps
    end
  end
end
