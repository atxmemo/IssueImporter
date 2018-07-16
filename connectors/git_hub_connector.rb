require 'json'
require_relative 'base_connector'

class GitHubConnector < BaseConnector
  include HTTParty
  base_uri 'api.github.com'

  def initialize(github_repo, github_user_name, github_auth_token)
    @github_repo = github_repo
    @github_user_name = github_user_name
    @github_auth_token = github_auth_token
  end

  def post_issues(github_issues)
    options = {headers: {'User-Agent' => @github_user_name, "Authorization" => "token #{@github_auth_token}"}}

    github_issues.each do |issue|
      options[:body] = issue.to_json
      response = self.class.post("/repos/#{@github_user_name}/#{@github_repo}/issues", options)
      puts options
      puts response.inspect
    end
  end

end