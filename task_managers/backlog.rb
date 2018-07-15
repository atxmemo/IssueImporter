class Backlog < BaseTaskManager

  def extract(options)
    project_key = options[:project_key]
    api_key = options[:api_key]
    github_repo = options[:github_repo]
    puts 'Backlog extracting'
    puts options
  end

end