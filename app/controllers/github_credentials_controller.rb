class GithubCredentialsController < ApplicationController
  def create
    current_user.update(github_uid: user_info['uid'].to_i)
    github_credentials
    redirect_to '/dashboard'
  end

  def user_info
    request.env['omniauth.auth']
  end

  def token
    user_info['credentials']['token']
  end

  def github_credentials
    if current_user.github_credential
      current_user.github_credential.update(token: token)
    else
      current_user.github_credential = GithubCredential.create(token: token)
    end
  end
end
