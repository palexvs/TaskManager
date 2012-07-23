class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.integer :priority
      t.datetime :deadline
      t.references :status
      t.references :project

      t.timestamps
    end
    add_index :tasks, :status_id
    add_index :tasks, :project_id
  end
end
