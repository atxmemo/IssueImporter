class BacklogIssue

  attr_accessor :summary
  attr_accessor :description
  attr_accessor :state

  def initialize(summary, description, state)
    @summary = summary
    @description = description
    @state = state
  end

end