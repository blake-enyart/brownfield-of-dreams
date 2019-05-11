class AddGithubCredentialToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :github_credential, foreign_key: true
  end
end
