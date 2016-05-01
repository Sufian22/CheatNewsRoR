class User < ActiveRecord::Base
  has_many :submissions
  has_many :comments
  has_many :replies
  acts_as_voter
end
