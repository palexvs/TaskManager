# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  email           :string(255)
#  password_digest :string(255)
#  sid             :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :sid
  has_many :project
  
  VALID_EMAIL_REGEX = /\A[\w+\-_+.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
            uniqueness: true,
            length: {maximum: 50},
            format: { with: VALID_EMAIL_REGEX }
  before_save { self.email = email.downcase } 

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, confirmation: true
  validates :password_confirmation, presence: true
end
