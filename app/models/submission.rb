class Submission < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  acts_as_votable
  scope :reversed, -> { order 'created_at DESC' }
  scope :ask, -> { where("link ='' or link is null")}
  scope :site_name, ->(site_name) { where site_name: site_name}
  scope :getSubmission, ->(id) { where id: id}
end
