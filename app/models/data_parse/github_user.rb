class DataParse::GithubUser
  attr_reader :handle,
              :github_url

  def initialize(data)
    @handle = data[:login]
    @github_url = data[:html_url]
  end
end
