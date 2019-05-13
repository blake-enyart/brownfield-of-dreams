class SearchResultsFacade
  # Search Github API for information on users
  # frozen_string_literal: true
  def initialize(token)
    @token = token
  end

  def repositories
    get_json('repos').take(5).map do |raw_repo|
      DataParse::Repo.new(raw_repo)
    end
  end

  def followers
    get_json('followers').map do |raw_user|
      DataParse::GithubUser.new(raw_user)
    end
  end

  private

    def conn
      url_path = 'https://api.github.com/user/'
      Faraday.new(url: url_path) do |faraday|
        faraday.params['access_token'] = @token
        faraday.adapter Faraday.default_adapter
      end
    end

    def get_json(url = nil)
      response = conn.get(url)
      JSON.parse(response.body, symbolize_names: true)
    end
end
