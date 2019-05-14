class DataParse::GithubUser
  attr_reader :handle,
              :github_url,
              :id

  def initialize(data)
    @id         = data[:id]
    @handle     = data[:login]
    @github_url = data[:html_url]
  end

  def in_database?
    User.find_by(github_uid: self.id)
  end
end
