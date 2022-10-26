# Git Command Line

[ExCl](https://docs.excl.ornl.gov/) → [User Documentation](../../) → [Contributing](../../excl-support/contributing.md) → [Git in the Command Line](git-command-line.md)

## Git Workflow from the Command Line

There are many reasons one would prefer to work from the command line. Regardless of your reasons, here is how to contribute to the ExCl documentation using only command line tools.

_Jump to a Section:_

* [Setup](git-command-line.md#setup)
* [Checkout](git-command-line.md#checkout)
* [Edit](git-command-line.md#edit)  &#x20;
* [Add](git-command-line.md#add)
* [Commit](git-command-line.md#commit)
* [Push](git-command-line.md#push)
* [Merge](git-command-line.md#merge)

This guide is adapted from [GitHub's documentation](https://docs.github.com/ee/gitHub-basics/start-using-git.html).

It is assumed that users of this guide understand basic Git/version control principles. To learn more about Git basics with our basic Git tutorial, visit [this page](./).

### Setup

*   First, use the command line to see if Git is installed.

    ```bash
    git --version
    ```

    * To install or update Git using your package manager:
      *   CentOS, RedHat:

          ```bash
          sudo yum install git
          sudo yum update git
          ```
      *   Debian, Ubuntu:

          ```bash
          sudo apt-get install git
          sudo apt-get update git
          ```
      *   MacOS, use [Homebrew](https://brew.sh/):

          ```bash
          /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
          brew install git
          brew upgrade git
          ```
      * Windows: download [Git for Windows](https://gitforwindows.org/) and install it.
*   Setup Git with your access credentials to GitHub with the following commands:

    ```bash
    git config --global user.name "your_username"
    git config --global user.email "your_email_address@example.com"
    ```

    * You can review the information that you entered during set-up: `git config --global --list`
* _(Optional)_ Consider adding your SSH key to your GitHub profile so you are not prompted for credentials after every commit. To add your public SSH key to GitHub:
  * Click on your user image in the top-right of the GitHub window.
  * Select `Settings`.
  * On the left, click `ssh keys`.
  * Paste your _**public**_ ssh key in the box, provide a title, and save by clicking `Add key`.
*   Clone an existing repository. In GitHub, this information is found on the "Overview" page of the repository.

    ```bash
    git clone git@code-int.ornl.gov:ex-cl/user-documentation.git
    ```

### Checkout

*   If you have already cloned the repository but are returning to your local version after a while, you'll want to make sure your local files are up to date with the branch. You can pull updates from _master_ or _branch\_name_.

    ```bash
    git pull origin branch_name
    ```
* You need to create a new branch or checkout an existing branch that can later be merged into the master branch. When naming branches, try to choose something descriptive.
  * To create a branch: `git checkout -b branch_name`
  * To list existing branches: `git branch -r`
  * To checkout an existing branch: `git checkout --track origin/branch_name` or `git checkout branch_name`
    * Note: You may only have one branch checked out at a time.

### Edit

* Make edits to the files with your favorite text editor. Save your changes.

### Add

*   Git places "added" files in a staging area as it is waiting for you finalize your changes.

    ```bash
    git add --all
    ```

### Commit

*   When you have added (or staged) all of your changes, committing them prepares them for the push to the remote branch and creates a snapshot of the repository at that moment in time.

    ```bash
    git commit -m "descriptive text about your changes"
    ```

### Push

*   After committing the edits, push the changes to GitHub. If the following produces an error, see below the code snippet for common solutions. The structure of this command is `git push <remote> <branch>`.

    ```bash
    git push
    ```

    * Upstream error: `git push --set-upstream origin branch_name` or `git push -u origin branch_name`

### Merge

At this time, GitHub does not natively support submissions for merge requests via the command line.

You can send a merge request using the GitHub GUI.

1. From the left menu panel in GitHub (when viewing the repository), select `Merge Request` then the green `New merge request` button.
2. Select your branch on the "Source Branch" side.
   * Target branch is _master_.
   * Click `compare branches`.
3. On the next screen the only thing needed is:
   * Assign to: _< Project Owner, etc. >_
   * Click `Submit merge request`.

#### Related Tutorials

* [Git Scenarios](https://github.com/ORNL-ExCL/excl-user-docs/tree/5b0a2bac08c6595857ffaa414e0a315a8fdfa27c/contributing/contributing/git-scenarios.md)
* [Contribute with Git and Atom](https://github.com/ORNL-ExCL/excl-user-docs/tree/5b0a2bac08c6595857ffaa414e0a315a8fdfa27c/contributing/contributing/git-workflow.md)
