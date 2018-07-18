require_relative '../issues/git_hub_issue'
require_relative '../issues/backlog_issue'
require_relative '../connectors/backlog_connector'

class BacklogTaskManager < BaseTaskManager

  def initialize(options)
    super(options[:github_repo], options[:github_user_name], options[:github_auth_token])
    @backlog_api_key = options[:backlog_api_key]
    @backlog_project_key = options[:backlog_project_key]
  end

  def extract
    raw_backlog_issues = BacklogConnector.new(@backlog_api_key,
                                              @backlog_project_key).get_raw_issues

    @backlog_issues = Array.new
    raw_backlog_issues.each do |raw_backlog_issue|
      @backlog_issues.push BacklogIssue.new(raw_backlog_issue['summary'],
                                            raw_backlog_issue['description'],
                                            raw_backlog_issue['status']['name'].downcase)
    end
  end

  def transform
    @backlog_issues.each do |backlog_issue|
      @unsaved_github_issues.push GitHubIssue.new(backlog_issue.summary,
                                                  backlog_issue.description,
                                                  backlog_issue.status)
    end
  end

end