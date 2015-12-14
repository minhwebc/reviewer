class Event < ActiveRecord::Base
  belongs_to :user
  validates :name, :date, :location, :state, :presence => true
  has_many :participants, dependent: :destroy
  has_many :going_users, through: :participants, source: :user
  has_many :comments, as: :commentable
end
