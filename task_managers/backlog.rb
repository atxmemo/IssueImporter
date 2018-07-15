require 'httparty'

class Backlog < BaseTaskManager

  @backlog_issues = nil

  def extract(options)
    project_key = options[:project_key]
    api_key = options[:api_key]

    @backlog_issues = HTTParty.get("https://#{project_key}.backlog.com/api/v2/issues?apiKey=#{api_key}")
                              .parsed_response
  end

  def transform
    puts 'transforming...'
  end

end