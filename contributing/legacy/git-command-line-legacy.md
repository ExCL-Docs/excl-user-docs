[CADES](http://cades.ornl.gov/) → [User Documentation](../README.md) → [Contributing](../CONTRIBUTE.md) → [Git in the Command Line](git-command-line.md)

# Git Workflow from the Command Line

There are many reasons one would prefer to work from the command line. Regardless of your reasons, here is how to contribute to the CADES documentation using only command line tools.

This guide is adapted from [GitLab's documentation](https://docs.gitlab.com/ee/gitlab-basics/start-using-git.html).

It is assumed that users of this guide understand basic git/version control principles. If not, we have a [git basics tutorial](git-basics.md). Or, to read more, visit [this page](https://git-scm.com/).

## Install Git and Set-up

1. First, check to see if git is installed.

  ```
  git --version
  ```

  - To install and/or update git using your package manager:

    - CentOS, RedHat:

      ```
      sudo yum install git
      sudo yum update git
      ```

    - Debian, Ubuntu:

      ```
      sudo apt-get install git
      sudo apt-get update git
      ```

    - MacOS, use [Homebrew](https://brew.sh/):

      ```
      /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
      brew install git
      brew upgrade git
      ```

    - Windows: download [Git for Windows](https://gitforwindows.org/) and install it.

2. Set-up git with your access credentials to GitLab with the following commands:

  ```
  git config --global user.name "your_username"
  git config --global user.email "your_email_address@example.com"
  ```

  - You can review the information that you entered during set-up: `git config --global --list`

3. _(Optional)_ Prior to cloning the repository, consider adding your ssh key to your GitLab profile so you will not be prompted for credentials after every commit. To add your public ssh key to GitLab:

  - Click on your user image in the top-right of the GitLab window.
  - Select `Settings`.
  - On the left, click `ssh keys`.
  - Paste your _**public**_ ssh key in the box, provide a title, and save by clicking `Add key`.

## Using Repositories and Branches

1. Clone an existing repository.

  ```
  git clone git@code-int.ornl.gov:cades-ops/user-documentation.git
  ```

  - If you have already cloned the repository but are returning to your local version after a while, you'll want to make sure your local files are up to date with the branch. You can pull updates from _master_ or from _branch_name_.

    ```
    git pull origin branch_name
    ```

2. You're ready to make edits using your favorite text editor. You will need to create a new branch or checkout an existing branch that will later be merged into the master branch. When naming branches, try to chose something descriptive.

  - To create a branch: `git checkout -b branch_name`
  - To list existing branches: `git branch -r`
  - To checkout an existing branch: `git checkout --track origin/branch_name` or `git checkout branch_name`

    - Note: You may only have one branch checked out at a time.

3. When you are satisfied with your changes, commit them to your branch by adding and committing the changes.

  ```
  git add --all
  git commit -m "descriptive text about your changes"
  ```

4. After committing the edits, you'll want to push the changes to GitLab. If the following produces an error, see below the code snippet for common solutions. The structure of this command is `git push <remote> <branch>`.

  ```
  git push
  ```

  - Upstream error: `git push --set-upstream origin branch_name` or `git push -u origin branch_name`

## Creating a Merge Request

At this time, GitLab does not natively support submissions for merge requests via the command line.

You can send a merge request using the GitLab GUI.

1. From the left menu panel in Gitlab, select `Merge Request` then the green `New merge request` button.
2. Select your branch in the "Source Branch" side.

  - Target branch will be _master_
  - Click `compare branches`.

3. On the next screen the only thing needed is simply:

  - Assign to: _< Project Owner, etc. >_
  - Click `Submit merge request`
