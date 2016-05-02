class User < ActiveRecord::Base
  has_many :submissions
  has_many :replies
  has_many :comments

  acts_as_voter

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.image = auth.info.image
      user.save!
    end
  end

end