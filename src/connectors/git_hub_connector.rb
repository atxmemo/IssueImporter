require 'github_api'

class GitHubConnector

  def initialize(github_repo, github_user_name, github_auth_token)
    @github_api = Github.new oauth_token: github_auth_token

    @required_parameters = {user: github_user_name, repo: github_repo}
  end

  def post_issue(github_issue)
    created_issue = @github_api.issues.create(@required_parameters.merge({title: github_issue.title, body: github_issue.body}))
    GitHubIssue.new(created_issue['title'], created_issue['body'], created_issue['state'], created_issue['number'])
  end

  def update_issue(github_issue)
    @github_api.issues.edit(@required_parameters.merge({number: github_issue.number, state: github_issue.state}))
  end

end