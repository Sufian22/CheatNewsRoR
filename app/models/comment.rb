class Comment < ActiveRecord::Base
  has_many :replies
  belongs_to :user
  belongs_to :submission
  acts_as_votable
end
