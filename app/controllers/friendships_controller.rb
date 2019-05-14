class FriendshipsController < ApplicationController
  def create
    future_friend = User.find_by(github_uid: params[:friend_id])
    current_user.friendships.create(user_id: current_user.id, friend_id: future_friend.id)
    future_friend.friendships.create(user_id: future_friend.id, friend_id: current_user.id)
    redirect_to dashboard_path
  end
end
