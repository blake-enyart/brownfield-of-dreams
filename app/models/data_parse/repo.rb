class DataParse::Repo
  # frozen_string_literal: true
  # Builds repo objects from JSON data feed in
  attr_reader :name, :html_url
  def initialize(data)
    @name = data[:name]
    @html_url = data[:html_url]
  end
end
