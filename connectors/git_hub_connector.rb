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
      @github_api.issues.create(user: @github_user_name, repo: @github_repo, title: issue.title, body: issue.body)
    end
  end

end