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

end