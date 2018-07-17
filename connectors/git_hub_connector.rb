require 'github_api'

class GitHubConnector

  def initialize(github_repo, github_user_name, github_auth_token)
    @github_repo = github_repo
    @github_user_name = github_user_name
    @github_auth_token = github_auth_token

    @github_api = Github.new oauth_token: @github_auth_token
  end

  def post_issues(github_issues)
    github_issues.each do |issue|
      created_issue = post_issue issue
      if issue.state == 'closed'
        update_issue_closed created_issue['number']
      end
    end
  end

  def post_issue(github_issue)
    @github_api.issues.create(user: @github_user_name, repo: @github_repo, title: github_issue.title, body: github_issue.body)
  end

  def update_issue(options)
    @github_api.issues.edit(user: @github_user_name, repo: @github_repo, number: number, state: 'closed')
  end

end