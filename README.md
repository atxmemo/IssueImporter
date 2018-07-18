# IssueImporter
A Ruby utility that connects to a task manager and imports tasks as GitHub Issues using the GitHub API

## Supported Task Managers to import into GitHub Issues
1. [Backlog](https://www.backlog.com/‎)

## Supported functionality
IssueImporter is capable of importing Issues to any private or public GitHub Repository. Supported GitHub issue fields that are imported include: `title`, `body`, `state`

## Getting Started
**Assumptions: Ruby 2.3.1 and the bundle gem installed**
To begin, cd into the top level (all commands in this README will be assumed to have been run from the top level IssueImporter directory) IssueImporter directory and run `bundle install` in order to  install all of the required dependencies.
From here, the `thor list` command can be used to see the list of available importer tasks. Currently only the `backlog` import task is available for usage.


### Backlog Importer
In order to get a more detailed description of the backlog task, try running the `thor help importer:backlog`

Below are the required parameters in order to get the job to run successfully:

### From GitHub Account
| Data                       | Description   |
| -------------------------- |:-------------:|
| GitHub Username            | GitHub user name |
| GitHub Repo                | The name of any private or public GitHub Repository to import backlog issues into |
| [GitHub Authorization Token](https://blog.github.com/2013-05-16-personal-api-tokens/) | GitHub personal access token (NOTE: Must have repo scope enabled) |

### From Backlog Account
| Data                       | Description   |
| -------------------------- |:-------------:|
| [Backlog Project Key](https://support.backlog.com/hc/en-us/articles/115015421127-Project-Settings)    | The unique identifier for a backlog project |
| [Backlog Api Key](https://support.backlog.com/hc/en-us/articles/115015420567-API-Settings)            | The api key used to identify and grant access to user |

Sample thor command usage:
`thor importer:backlog --backlog-project-key atxmemo --backlog-api-key CJTsnun6jkj876Emn213xkjghtjlGllsrFC8ujtuBIvnRxjAbWSeE14cqX3GAzFL --github-repo HelloGitHubRepo --github-user-name HelloUserName --github-auth-token 60d0c4f0a321f42227d6811b3cb4fe93b946hn74`

Once all of these pieces of data have been collected and issues have been created in Backlog in order to import them into a GitHub repository, the task can be run. 

## Adding additional task managers to the code
This project was designed with extensibility in mind. In order to add additional task managers to pull data from and import into GitHub there are only a couple steps that have to be taken.

1. Create a task manager class under task_managers and have it extend `BaseTaskManager`
2. Create a connector that will make the HTTP calls to retrieve the issues from this new task manager
3. In the initialize method, call the super method and set the GitHub connector in the `BaseTaskManager`
4. Create an issue class for this newly created type of issue that is being imported into GitHub
5. Implement the `extract` method, loading tasks from the new task manager into an instance variable collection of issues of the type created in Step # 3
6. Implement the `transform` method, iterating over the issues set in the `extract` method, and creating a collection of GitHub issues and setting them on the `@unsaved_github_issues` instance variable (to be picked up by the `BaseTaskManager` load method)
7. Add the newly created task manager in the `importer.thor` file, give it the provided github connector, credentials for the task manager connector and kick off the import by calling `import` on the task manager

## Testing
In order to run the RSpec test suite, run the `rspec spec` command.

The test suite covers the `extract` and `transform` method in each of the task manager class. 
Any additional task manager that is added should add a file under the `spec` directory and define tests for the new file. 

## Changes I would make had there been more time to work on this project (in order of importance)

1. Error handling framework around the connectors in order to gracefully handle any exceptions being thrown
2. Validating GitHub credentials, repository, user name and any other credentials used to connect to the task manager in question (currently required by thor but not validated)
3. Handle pagination if the task manager in question has a result set large enough to warrant this functionality
4. Asynchronously import the issues into GitHub using a background job
5. Add a nice UI in front of this utility
