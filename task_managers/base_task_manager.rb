class BaseTaskManager

  def import(options)
    @github_repo = options[:github_repo]
    @github_issues = Array.new

    start = Time.now

    extract options

    transform

    load

    stop = Time.now

    puts "Imported x number of issues and took #{(stop - start) * 1000} milli seconds"
  end

  def load
    puts @github_issues.inspect
  end

end