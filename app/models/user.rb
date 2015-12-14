class User < ActiveRecord::Base
  has_secure_password
  email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :email, :location, :state, :password, :presence => true
  validates :email, uniqueness: { case_sensitive: false }, :format => { :with => email_regex }
  validates :password, length: {minimum: 8}
  has_many :comments
  has_many :events
  has_many :participants, dependent: :destroy
  has_many :going_events, through: :participants, source: :event

end
