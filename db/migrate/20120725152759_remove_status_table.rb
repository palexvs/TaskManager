class RemoveStatusTable < ActiveRecord::Migration
  def change
    drop_table :statuses
    remove_column :tasks, :status_id
  end
end