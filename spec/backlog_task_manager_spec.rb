require_relative '../src/task_managers/base_task_manager'
require_relative '../src/task_managers/backlog_task_manager'

RSpec.describe BacklogTaskManager do

  it 'ensures extract method sets raw response into @backlog_issues' do
    github_connector = double
    backlog_connector = double

    backlog_issue_summary = 'Need to fix all the things'
    backlog_issue_description = 'Go fix each broken thing one by one until it is fixed'
    backlog_issue_status = 'closed'

    backlog_response = {}
    backlog_response['summary'] = backlog_issue_summary
    backlog_response['description'] = backlog_issue_description
    backlog_response['status'] = {}
    backlog_response['status']['name'] = backlog_issue_status


    allow(backlog_connector).to receive(:get_raw_issues).and_return([backlog_response])

    backlog_task_manager = BacklogTaskManager.new(github_connector, backlog_connector)
    backlog_task_manager.extract

    backlog_issue = backlog_task_manager.instance_variable_get(:@backlog_issues).first

    expect(backlog_issue.summary).to  eq(backlog_issue_summary)
    expect(backlog_issue.description).to  eq(backlog_issue_description)
    expect(backlog_issue.status).to eq(backlog_issue_status)
  end

  it 'ensures transform method sets @unsaved_github_issues from @backlog_issues' do
    github_connector = double
    backlog_connector = double

    backlog_issue_summary = 'Need to fix all the things'
    backlog_issue_description = 'Go fix each broken thing one by one until it is fixed'
    backlog_issue_status = 'closed'

    backlog_task_manager = BacklogTaskManager.new(github_connector, backlog_connector)
    backlog_task_manager.instance_variable_set(:@unsaved_github_issues, Array.new)
    backlog_task_manager.instance_variable_set(:@backlog_issues, [BacklogIssue.new(backlog_issue_summary, backlog_issue_description, backlog_issue_status)])

    backlog_task_manager.transform

    unsaved_github_issue = backlog_task_manager.instance_variable_get(:@unsaved_github_issues).first

    expect(unsaved_github_issue.title).to eq(backlog_issue_summary)
    expect(unsaved_github_issue.body).to  eq(backlog_issue_description)
    expect(unsaved_github_issue.state).to eq(backlog_issue_status)
  end

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