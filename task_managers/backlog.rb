require 'httparty'
require_relative '../issues/git_hub_issue'
require_relative '../issues/backlog_issue'

class Backlog < BaseTaskManager

  def extract(options)
    backlog_project_key = options[:backlog_project_key]
    backlog_api_key = options[:backlog_api_key]

    @backlog_issues = Array.new
    raw_backlog_issues = HTTParty.get("https://#{backlog_project_key}.backlog.com/api/v2/issues?apiKey=#{backlog_api_key}")
                              .parsed_response

    raw_backlog_issues.each do |raw_backlog_issue|
      @backlog_issues.push BacklogIssue.new(raw_backlog_issue['summary'], raw_backlog_issue['description'])
    end
  end

  def transform
    @backlog_issues.each do |backlog_issue|
      @gitub_issues.push GitHubIssue.new(backlog_issue.summary, backlog_issue.description)
    end
  end

end