class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_one :github_credential
  has_many :friendships
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true
  validates_presence_of :first_name
  enum role: [:default, :admin]
  enum status: [:inactive, :active]
  has_secure_password

  def already_friends?(github_uid)
    user = User.find_by(github_uid: github_uid)
    if user
      user.friends.include?(self)
    else
      false
    end
  end

  def sorted_bookmarked_videos
    bookmarked_videos.each_with_object({}) do |video, hash|
      hash[video.tutorial_title] ||= []
      hash[video.tutorial_title] << video
    end
  end

  private

  def bookmarked_videos
    Video.joins(:user_videos, :tutorial)
         .where(user_videos: { user_id: id })
         .select('videos.*,
                  tutorials.title AS tutorial_title,
                  tutorials.id AS tutorial_id')
  end
end
