require_relative 'base_connector'

class BacklogConnector < BaseConnector

  def initialize(backlog_api_key, backlog_project_key)
    @backlog_api_key = backlog_api_key
    @backlog_project_key = backlog_project_key
  end

  def get_raw_issues
    HTTParty.get("https://#{@backlog_project_key}.backlog.com/api/v2/issues?apiKey=#{@backlog_api_key}")
            .parsed_response
  end

end