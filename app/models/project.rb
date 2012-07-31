# == Schema Information
#
# Table name: projects
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :string(255)
#  user_id     :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Project < ActiveRecord::Base
  belongs_to :user
  attr_accessible :description, :name
  has_many :task, :dependent => :destroy, :order => "priority ASC"

  scope :with_task, includes(:task)

  validates :name, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 255 }
end
