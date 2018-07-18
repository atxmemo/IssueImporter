require_relative 'src/task_managers/base_task_manager'
require_relative 'src/task_managers/backlog_task_manager'

class Importer < Thor

  desc 'backlog', 'This task will import issues from a BacklogTaskManager project into a GitHub Repository'
  method_option :backlog_project_key, required: true, type: :string, desc: 'The unique identifier for a backlog project: https://support.backlog.com/hc/en-us/articles/115015421127-Project-Settings'
  method_option :backlog_api_key, required: true, type: :string, desc: 'The api key used to identify and grant access to user: https://support.backlog.com/hc/en-us/articles/115015420567-API-Settings'
  method_option :github_repo, required: true, type: :string, desc: 'The name of any private or public GitHub Repository to import backlog issues into'
  method_option :github_user_name, required: true, type: :string, desc: 'GitHub user name'
  method_option :github_auth_token, required: true, type: :string, desc: 'GitHub personal access token (NOTE: Must have repo scope enabled): https://blog.github.com/2013-05-16-personal-api-tokens/'
  def backlog
    BacklogTaskManager.new(options).import
  end

end