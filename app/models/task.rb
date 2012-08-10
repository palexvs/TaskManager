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
  attr_accessible :deadline, :description, :name, :done

  delegate :name, :to => :project, :prefix => true

  validates :name, presence: true, length: { maximum: 125 }
  validates :description, length: { maximum: 255 }

  validate :deadline_cannot_be_in_the_past

  after_create :set_priority

  def change_priority(direction=nil)
    if direction == 'up'
      task_next = Task.where('project_id = ? AND priority < ?', self.project_id, self.priority).order("priority ASC").last
    elsif direction == 'down'
      task_next = Task.where('project_id = ? AND priority > ?', self.project_id, self.priority).order("priority ASC").first
    end

    if !task_next.nil?
      task_next.priority, self.priority = self.priority, task_next.priority
      if task_next.save and self.save
        return true
      end
    end    
    errors.add(:priority, "can't change")
    return false
  end

  private

  def set_priority
    self.priority = self.id
    self.save
  end

  def deadline_cannot_be_in_the_past
    if !self.deadline.blank? and self.deadline < Date.today
      errors.add(:deadline, "can't be in the past")
    end
  end
end
