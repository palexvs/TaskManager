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

class Task < ActiveRecord::Base
  belongs_to :status
  belongs_to :project
  attr_accessible :deadline, :description, :name, :priority, :done

  delegate :name, :to => :project, :prefix => true

  validates :name, presence: true, length: { maximum: 125 }
  validates :description, length: { maximum: 255 }
  validates :priority, numericality: { only_integer: true, less_than: 100, greater_than_or_equal_to: 0 }

  validate :deadline_cannot_be_in_the_past

  def deadline_cannot_be_in_the_past
    if !deadline.blank? and deadline < Date.today
      errors.add(:deadline, "can't be in the past")
    end
  end
end
