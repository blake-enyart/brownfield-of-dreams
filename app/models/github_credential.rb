class GithubCredential < ApplicationRecord
  # frozen_string_literal: true
  # Model to access github_credentials table in db
  belongs_to :user
end
