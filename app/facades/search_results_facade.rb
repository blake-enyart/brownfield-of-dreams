class SearchResultsFacade
  # Search Github API for information on users
  # frozen_string_literal: true

  def initialize(token)
    @token = token
  end

  def repositories
    raw_repo_data = get_json('repos').map do |raw_repo|
      Repo.new(raw_repo)
    end
    select_repos(raw_repo_data, 5)
  end

  def select_repos(raw_repo_data, amount)
    raw_repo_data[0..(amount-1)]
  end

  private

    def conn
      url_path = "https://api.github.com/user/"
      Faraday.new(url: url_path) do |faraday|
          faraday.params["access_token"] = @token
          faraday.adapter Faraday.default_adapter
      end
    end

    def get_json(url=nil)
      response = conn.get(url)
      JSON.parse(response.body, symbolize_names: true)
    end
end
