class BaseTaskManager

  @github_repo = nil

  def import(options)
    @github_repo = options[:github_repo]

    start = Time.now

    extract options

    transform

    load

    stop = Time.now

    puts "Imported x number of issues and took #{(stop - start) * 1000} milli seconds"
  end

  def load
    puts 'loading...'
  end

end