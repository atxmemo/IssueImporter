require_relative '../connectors/git_hub_connector'

class BaseTaskManager

  def initialize(github_connector)
    @github_connector = github_connector
  end

  def import
    # Sub classes will populate this field in their implemented #extract method
    @unsaved_github_issues = Array.new

    @imported_issues = 0

    start = Time.now

    # Have subclass extract issues from any task manager using a dedicated connector
    extract

    # Have subclass transform issues that were extracted into GitHub issues
    transform

    # Post GitHub issues into GitHub and ensure any fields that can't be set during create are updated during subsequent update
    load

    stop = Time.now

    puts "Imported #{@imported_issues} issue(s) and took #{(stop - start) * 1000} milli seconds"
  end

  def load
    # Issues that might need to be updated because the GitHub Create Issue API does not allow for these parameters to be set
    github_issues_to_update = []

    @unsaved_github_issues.each do |unsaved_github_issue|
      saved_github_issue = @github_connector.post_issue unsaved_github_issue

      # After each validation the saved_github_issue will have the correct values which we can then use to update the issue
      validate_status unsaved_github_issue, saved_github_issue, github_issues_to_update

      @imported_issues = @imported_issues + 1
    end

    # Update any issues that failed the validation
    github_issues_to_update.each do |github_issue_to_update|
      @github_connector.update_issue github_issue_to_update
    end
  end

  def validate_status(unsaved_github_issue, saved_github_issue, github_issues_to_update)
    unless unsaved_github_issue.state == saved_github_issue.state
      # unsaved_github_issue state takes precedence - as it comes from the subclass transform method
      saved_github_issue.state = unsaved_github_issue.state
      github_issues_to_update.push(saved_github_issue)
    end
  end

end