class Submission < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  scope :reversed, -> { order 'created_at DESC' }
  scope :ask, -> { where("link ='' or link is null")}
end
