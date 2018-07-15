require_relative 'task_managers/base_task_manager'
require_relative 'task_managers/backlog'

class Importer < Thor

  desc 'backlog', 'This task will import issues from a backlog project into a GitHub Repository'
  method_option :project_key, required: true, type: :string, desc: 'The unique identifier for a backlog project: https://support.backlog.com/hc/en-us/articles/115015421127-Project-Settings'
  method_option :api_key, required: true, type: :string, desc: 'The api key used to identify and grant access to user: https://support.backlog.com/hc/en-us/articles/115015420567-API-Settings'
  method_option :github_repo, required: true, type: :string, desc: 'Any private or public GitHub Repository to import backlog issues into'
  def backlog
    backlog = Backlog.new
    backlog.import(options)
  end

end