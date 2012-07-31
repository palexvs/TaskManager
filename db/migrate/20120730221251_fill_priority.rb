class FillPriority < ActiveRecord::Migration
  def change
    Task.all.each do |task|
      task.update_attributes(priority: task.id) 
    end

    add_index :tasks, [:project_id, :priority]
    add_index :tasks, [:project_id, :id]
  end
end
