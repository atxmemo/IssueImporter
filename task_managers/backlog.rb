require 'httparty'

class Backlog < BaseTaskManager

  def extract(options)
    backlog_project_key = options[:backlog_project_key]
    backlog_api_key = options[:backlog_api_key]

    @backlog_issues = HTTParty.get("https://#{backlog_project_key}.backlog.com/api/v2/issues?apiKey=#{backlog_api_key}")
                              .parsed_response
  end

  def transform
    @backlog_issues.each do |backlog_issue|
      @gitub_issues.push Hash[{title: backlog_issue['summary'], body: backlog_issue['description']}]
    end
  end

end