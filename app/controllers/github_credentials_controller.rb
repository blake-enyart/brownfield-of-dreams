class GithubCredentialsController < ApplicationController
  # frozen_string_literal: true
  
  def create
    user_info = request.env['omniauth.auth']
    token = user_info['credentials']['token']
    if !current_user.github_credential
      current_user.github_credential = GithubCredential.create(token: token)
    else
      current_user.github_credential.update(token: token)
    end
    redirect_to '/dashboard'
  end
end
