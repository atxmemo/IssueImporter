class GitHubIssue

  attr_accessor :title
  attr_accessor :body
  attr_accessor :state

  def initialize(title, body, state)
    @title = title
    @body = body
    @state = state
  end

end