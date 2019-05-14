class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_one :github_credential
  has_many :friendships
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def already_friends?(github_uid)
    user = User.find_by(github_uid: github_uid)
    if user
      user.friends.include?(self)
    else
      false
    end
  end
end
