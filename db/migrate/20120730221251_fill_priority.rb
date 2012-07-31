class FillPriority < ActiveRecord::Migration
  def up
    Task.all.each do |task|
      task.update_attributes(priority: task.id) 
    end
  end

  def change
    add_index :tasks, [:project_id, :priority]
    add_index :tasks, [:project_id, :id]
  end

  def down
  end
end
