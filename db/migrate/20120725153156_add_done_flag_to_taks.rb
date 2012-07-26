class AddDoneFlagToTaks < ActiveRecord::Migration
  def change
    change_table :tasks do |t|
      t.boolean :done, :default => false
    end
  end
end
