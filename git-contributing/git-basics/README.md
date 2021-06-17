# Git Basics

[ExCl](https://docs.excl.ornl.gov) → [User Documentation](../../) → [Contributing](https://github.com/ORNL-ExCL/excl-user-docs/tree/5b0a2bac08c6595857ffaa414e0a315a8fdfa27c/CONTRIBUTE.md) → [Git Basics](./)

## Git Basics

**Git**, like other version control \(VC\) software/system \([see a Wikipedia list](https://en.wikipedia.org/wiki/List_of_version_control_software)\), tracks changes to a file system over time. It is typically used in software development but can be used to monitor changes in any file.

> **Git** - a version control system that records the changes to a file or files which allows you to return to a previous version

📝 **Note:** This tutorial uses only the command line. After you have learned the basics of Git, you can explore a Git workflow [in the command line](git-command-line.md), or [with the Atom text editor](git-workflow.md), and also, common [Git scenarios](git-scenarios.md).

### ORNL Git Resources

When we talk about Git, we say that a **repository** stores files. This term means that you have a folder that is currently being tracked by Git. It is common, although optional, to use one of the Git repository \(repo\) services \(GitHub, GitLab, BitBucket, etc.\). You could easily set up Git tracking on your local machine only, but one of the perks to using Git is that you can share your files with others and a team can edit files collaboratively. The ability to collaborate is one of the many reasons why hosted Git repos are so popular.

> **Repository** - the Git data structure which contains files and folders, as well as how the files/folders have changed over time

ORNL provides two GitLab servers [https://code.ornl.gov](https://code.ornl.gov) and [https://code-int.ornl.gov](https://code-int.ornl.gov), the latter being accessible only inside of ORNL. Project owners control access to GitLab repositories. You may log in and create your projects and repositories, and share them with others.

### Accessing GitLab

* In your browser, navigate to [https://code.ornl.gov/](https://code.ornl.gov/) and login using your UCAMS credentials. Click on the green button at the top of the window that says `New project`.
* Choose the `Blank project` tab, create a name for the project, and select the "Visibility Level" that you prefer. Then click `Create project`.
* Notice that GitLab has provided instructions to perform Git setup and initialization of your repository. We will follow those instructions.
* _\(Optional\)_ Prior to cloning the repository, consider adding your SSH key to your GitLab profile so you are not prompted for credentials after every commit. To add your public SSH key to GitLab:
  * Click on your user image in the top-right of the GitLab window.
  * Select `Settings`.
  * On the left, click `SSH keys`.
  * Paste your _**public**_ SSH key in the box, provide a title, and save by clicking `Add key`.

### Local Machine Setup

* First, use the command line to see if Git is installed. \(Windows users may check their list of currently installed programs.\)

  ```bash
  git --version
  ```

  * To install or update Git using your package manager:
    * CentOS, RedHat:

      ```bash
      sudo yum install git
      sudo yum update git
      ```

    * Debian, Ubuntu:

      ```bash
      sudo apt-get install git
      sudo apt-get update git
      ```

    * MacOS, use [Homebrew](https://brew.sh/):

      ```bash
      /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
      brew install git
      brew upgrade git
      ```

    * Windows: download [Git for Windows](https://gitforwindows.org/) and install it. Also, this tutorial utilizes a Bash command line interface, therefore, you should use _Git Bash_, which is a part of the Git installation package for Windows.

* Setup Git with your access credentials to GitLab with the following commands \(use your ORNL email\):

  ```bash
  git config --global user.name "your_username"
  git config --global user.email "your_email_address@example.com"
  ```

  * You can review the information that you entered during set-up: `git config --global --list`

* Now, navigate to the location where you'd like to place your repository. For example:

  ```bash
  cd /home/user/projects/
  ```

* **Clone** the repository. A new folder is created, and Git starts tracking. Consult the repository information from the GitLab new repository window.

  > **Clone** - is the equivalent of making a local copy on your computer

  ```bash
  git clone git@code.ornl.gov:2ws/example-project.git
  cd example-project/
  ```

* GitLab also recommends the creation of a `README.md` file to describe the repository. \(We will edit the contents of the README.md file later.\)

  ```bash
  touch README.md
  ```

* The next three steps consist of `adding`, `committing`, and `pushing` from your local machine to GitLab.

  > **Add** - includes the added files in the content that you want to save  
  >  **Commit** - creates a "snapshot" of the repository at that moment and uses the changes from the "added" files  
  >  **Push** - moves/uploads the local changes \(or snapshot\) to the remote GitLab repository

  ```bash
  git add README.md
  git commit -m "add README"
  git push -u origin master
  ```

  * _\(Optional\)_ If you like, you can refresh your browser page, and you can see that the `README.md` file is now in your repository.

### Using Branches to Make Changes

**Branches** are created as a way to separate content that is still under development. One way to think about a branch is as a copy of the content of a repository at a point in time. You'll then make your changes on the _copy_ before then integrating the changes back into the original. For example, if you were using your GitLab repo to host a website, you probably would not want incomplete content shown to those who would visit your site. Instead, you can create a branch, make edits to the files there, then **merge** your development branch back into the `master` branch, which is the default branch. Additionally, branches are commonly used when multiple individuals work out of a single repository.

> **Branch** - a version of the repository that splits from the primary version  
>  **Merge** - using the changes from one branch and adding them to another

* A branch **checkout** enables you to make changes to files without changing the content of the `master` branch. To create and checkout a branch called "adding-readme":

  ```bash
  git checkout adding-readme
  ```

> **Checkout** - Git command to change branches

* Now we edit the `README.md` file to add a description of the repository. The file needs to be opened with a text editor \(nano, vim, emacs, etc.\).

  ```bash
  vi README.md
  ```

* Add your description. `README.md` is a markdown file. If you do not know how to use markdown, don't worry. Basic text works, too. However, if you would like to learn markdown, it is simple. [Use this GitLab tutorial](https://docs.gitlab.com/ee/user/markdown.html#standard-markdown).
  * To type in `vi`, press `i` for _insert_. Now you can add content.
  * To save your changes and exit `vi`, press `<esc>` to leave editing, then type `:wq` which writes \(saves\) and quits.
* As before, we need to add, commit, and push the changes to the GitLab repository.

  ```bash
  git add README.md
  git commit -m "added a description of the repository"
  git push --set-upstream origin adding-readme
  ```

  * In future pushes, you can simplify the last command by typing only `git push`. However, the first time you push to a new branch, you have to tell GitLab that you have created a new branch on your computer and the changes that you are pushing should be pushed to a new _remote_ branch called `adding-readme`.

### Merging Content from a Development Branch to the Master Branch

After completing the previous section, we have two branches: `adding-readme` and `master`. We are ready to move the `adding-readme` content to the `master` branch.

You can create a merge request using the GitLab GUI.

* From the left menu panel in Gitlab \(when viewing the repository\), select `Merge Request` then the green `New merge request` button.
* Select your branch on the "Source Branch" side \(`adding-readme`\).
  * Target branch is _master_.
  * Click `Compare branches and continue`.
* You can add as much information to the next screen as you like, but the only thing needed is:
  * Assign to: _&lt; Project Owner, etc. &gt;_
    * In our case, we are the project owner, so we may assign the merge request to ourselves.
  * Click `Submit merge request`.
* On the next page, click the green `Merge` button.

From the left menu panel in Gitlab, select `Overview` to see the new `README.md` content.

#### External Reference Material

* [Git Glossary](https://git-scm.com/docs/gitglossary)

Sometimes Git repository sites use different terminology, i.e., _merge request_ vs. _pull request_. To reference the glossaries:

* [GitLab Glossary](https://docs.gitlab.com/ee/university/glossary/)
* [GitHub Glossary](https://help.github.com/articles/github-glossary/)
* [BitBucket Glossary](https://www.atlassian.com/git/glossary/terminology)

#### Ready to Learn More?

* [Contribute with Git and Atom](git-workflow.md)
* [Git in the Command Line](git-command-line.md)
* [Git Scenarios](git-scenarios.md)

