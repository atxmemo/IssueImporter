require_relative '../src/task_managers/base_task_manager'

RSpec.describe BacklogTaskManager do

  it 'ensures validate_status method overrides saved_github attributes into unsaved_github_issue ' do
    github_connector = double

    base_task_manager = BaseTaskManager.new(github_connector)

    github_issue_summary = 'Need to fix all the things'
    github_issue_description = 'Go fix each broken thing one by one until it is fixed'

    unsaved_github_issue_state = 'closed'
    saved_github_issue_state = 'open'

    expect(unsaved_github_issue_state).not_to eq(saved_github_issue_state)

    unsaved_github_issue = GitHubIssue.new(github_issue_summary, github_issue_description, unsaved_github_issue_state)
    saved_github_issue = GitHubIssue.new(github_issue_summary, github_issue_description, saved_github_issue_state)

    github_issues_to_update = []
    base_task_manager.validate_status(unsaved_github_issue, saved_github_issue, github_issues_to_update)

    github_issue_to_update =  github_issues_to_update.first
    expect(github_issue_to_update.title).to eq(unsaved_github_issue.title)
    expect(github_issue_to_update.body).to  eq(unsaved_github_issue.body)
    expect(github_issue_to_update.state).to eq(unsaved_github_issue.state)
  end

end