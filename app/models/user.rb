class User < ActiveRecord::Base
  has_many :submissions
  has_many :replies
  has_many :comments

  acts_as_voter

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable
  #include DeviseTokenAuth::Concerns::User


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.image = auth.info.image
      user.save!
    end
  end

end