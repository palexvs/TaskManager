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

  validate :deadline_cannot_be_in_the_past

  before_create :set_priority

  def change_priority(direction=nil)
    if direction == 'up'
      task_next = Task.where('project_id = ? AND priority < ?', self.project_id, self.priority).order("priority ASC").last
    elsif direction == 'down'
      task_next = Task.where('project_id = ? AND priority > ?', self.project_id, self.priority).order("priority ASC").first
    end

    if !task_next.nil?
      task_next.priority, self.priority = self.priority, task_next.priority
      task_next.save
      self.save
    end    
  end

  private

  def set_priority
    self.priority = Task.last.id + 1
  end

  def deadline_cannot_be_in_the_past
    if !deadline.blank? and deadline < Date.today
      errors.add(:deadline, "can't be in the past")
    end
  end
end
