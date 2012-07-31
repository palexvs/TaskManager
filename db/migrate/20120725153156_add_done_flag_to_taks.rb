class AddDoneFlagToTaks < ActiveRecord::Migration
  def up
    Task.update_all(done: false)
  end
end
