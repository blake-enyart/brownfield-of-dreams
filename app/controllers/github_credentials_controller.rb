class GithubCredentialsController < ApplicationController
  # frozen_string_literal: true
  def create
    user_info = request.env['omniauth.auth']
    token = user_info['credentials']['token']
    current_user.update(github_uid: user_info['uid'].to_i)
    unless current_user.github_credential
      current_user.github_credential = GithubCredential.create(token: token)
    else
      current_user.github_credential.update(token: token)
    end
    redirect_to '/dashboard'
  end
end
