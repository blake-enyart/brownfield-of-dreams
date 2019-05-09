class Repo
  attr_reader :name, :html_url
  def initialize(data)
    @name = data[:name]
    @html_url = data[:html_url]
  end
end
