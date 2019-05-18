class FriendshipsController < ApplicationController
  def create
    current_user_friendship
    future_friend_friendship
    redirect_to dashboard_path
  end

  private

  def future_friend
    User.find_by(github_uid: params[:friend_id])
  end

  def current_user_friendship
    current_user.friendships.create(user_id: current_user.id,
                                    friend_id: future_friend.id)
  end

  def future_friend_friendship
    future_friend.friendships.create(user_id: future_friend.id,
                                     friend_id: current_user.id)
  end
end
