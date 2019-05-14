class AddGithubUidToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :github_uid, :integer
  end
end
