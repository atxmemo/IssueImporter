class BacklogIssue

  attr_accessor :summary
  attr_accessor :description

  def initialize(summary, description)
    @summary = summary
    @description = description
  end

end