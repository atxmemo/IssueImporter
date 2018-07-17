class BacklogIssue

  attr_accessor :summary
  attr_accessor :description
  attr_accessor :status

  def initialize(summary, description, status)
    @summary = summary
    @description = description
    @status = status
  end

end