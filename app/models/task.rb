# == Schema Information
#
# Table name: tasks
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :string(255)
#  priority    :integer
#  deadline    :datetime
#  status_id   :integer
#  project_id  :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Task < ActiveRecord::Base
  belongs_to :status
  belongs_to :project
  attr_accessible :deadline, :description, :name, :priority

  delegate :name, :to => :status, :prefix => true
  delegate :name, :to => :project, :prefix => true

  validates :name, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 255 }
  validates :priority, presence: true, numericality: { only_integer: true, less_than: 100 }
  validates :deadline, presence: true

  validate :deadline_cannot_be_in_the_past

  def deadline_cannot_be_in_the_past
    if !deadline.blank? and deadline < Date.today
      errors.add(:deadline, "can't be in the past")
    end
  end  
end
