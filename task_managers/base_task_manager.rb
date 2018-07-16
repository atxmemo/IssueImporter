require_relative '../connectors/git_hub_connector'

class BaseTaskManager

  def import(options)
    @github_connector = GitHubConnector.new(options[:github_repo],
                                            options[:github_user_name],
                                            options[:github_auth_token])

    @github_issues = Array.new

    start = Time.now

    extract options

    transform

    load

    stop = Time.now

    puts "Imported x number of issues and took #{(stop - start) * 1000} milli seconds"
  end

  def load
    @github_connector.post_issues @github_issues
  end

end