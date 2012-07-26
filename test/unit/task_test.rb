# == Schema Information
#
# Table name: tasks
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :string(255)
#  priority    :integer
#  deadline    :datetime
#  project_id  :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  done        :boolean         default(FALSE)
#

require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
