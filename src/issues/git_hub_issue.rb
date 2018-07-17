class GitHubIssue

  attr_accessor :title
  attr_accessor :body
  attr_accessor :state
  attr_accessor :number

  def initialize(title, body, state = 'open', number = -1)
    @title = title
    @body = body
    @state = state
    @number = number
  end

end