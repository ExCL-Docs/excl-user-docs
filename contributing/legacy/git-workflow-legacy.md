[CADES](http://cades.ornl.gov/) → [User Documentation](../README.md) → [Contributing](../CONTRIBUTING.md) → [Git Workflow](contributing/git-workflow.md)

# Recommended Workflow for Git and Atom

GitLab is a popular platform to share code, store software solutions, and host documentation.

ORNL provides two GitLab servers https://code.ornl.gov and https://code-int.ornl.gov, the later being accessible only inside of ORNL.

Access to GitLab repositories is controlled by project owners. You may login and create your own projects and repositories, and share them with others.

While there are many text editors to choose from, Atom is recommended due to its ability to be customized and integrated with GitLab/Git.

> Install Atom: [https://atom.io/](https://atom.io/)

Would you prefer not to use Atom? Here is git documentation for [git in the command line](git-command-line.md).

### CADES User Documentation

Documentation published to CADES users is available within Gitlab at https://code-int.ornl.gov/cades-ops/user-documentation and users are encouraged to contribute to improving the material, or providing user created tutorials to share with the community.

## Configuring Atom and Git

Atom has several packages which enhance the user experience and some of them you'll need for the workflow. The packages can be installed by entering the `Settings` screen and choosing `Install`. There are thousands of packages, so try some out and have fun.

1. Necessary Packages:
  * git-plus (integrates Git)
  * todo-show (provides visuals for TODO and FIXME tags)
- Optional but Recommended Packages:
  * linter (aids in code validation, will also need linter package for each language)
  * minimap (displays thumbnail version of document along with your location within it)
  * git-checkout (allows checking out remote branches within Atom)
- Now that Atom is set-up, you'll need to make sure Git knows who you are. You'll only need to complete this step if you've never used Git on your machine before.
- Open a terminal window.
-  If you need to install Git, see [here](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) for detailed instructions for popular operating systems.
- To configure Git, input your user name and email as below:
  * `git config --global user.name "ab1"` (3-letter UCAMS username)
  * `git config --global user.email "nameab@ornl.gov"` (ORNL email)



## Connecting Atom to a Repository

1. Navigate to the GitLab repository in your web browser. For this example, we'll use the `user-documentation` repository. Copy the SSH address to your machine's clipboard.   
<a target="_new" href="screenshots/git-repo-ssh-address.png"><img src="screenshots/git-repo-ssh-address.png" style="border-style:ridge;border-color:#bfbfbf;border-width:1px;width:550px;" /></a><!-- o_ -->   
-  Now, back inside Atom, open the `Command Palette`. On Mac, press `shift`+`command`+`p`. In Windows/Linux, press `control`+`shift`+`p`.
-  Type `git clone` and press `enter`.
-  Paste the SSH address in the resulting window. You may also modify the location of the local folder.
-  Wait for the repository to clone.
-  Now you can see the files have populated into the folder you specified. These files represent a local copy, to which you will make changes.
-  Before you leave GitLab's webpage, consider adding your SSH key to your profile so you will not be prompted for credentials after every commit. To add your public SSH key to GitLab:
  - Click on your user image in the top-right of the GitLab window.
  - Select `Settings`.
  - On the left, click `SSH keys`.
  - Paste your _**public**_ SSH key in the box, provide a title, and save by clicking `Add key`.

&#128221; **Note:** You have now checked out the master branch of the remote repository. You may lack permission to push your changes to master, or may wish not to do so.

## Working from Branches

At this point you likely either want to create a new branch and add your contributions there, or checkout a different branch you or someone else has already created. Each of these options are shown next. Unless you have reason otherwise you should choose one of these, rather than attempting to work from the master branch.

### Create a New Branch

1. Create a git branch by clicking on the `master` button on the bottom-right of the Atom window. Name the branch something descriptive.   
<a target="_new" href="screenshots/git-new_branch_atom.png"><img src="screenshots/git-new_branch_atom.png" style="border-style:ridge;border-color:#bfbfbf;border-width:1px;width:550px;" /></a><!-- o_ -->   

### Checkout an Existing Branch

We will need the name of the remote branch we wish to work on

1. The GitLab project page displays a droplist with the name of available branches.   
<a target="_new" href="screenshots/git-show-branches.png"><img src="screenshots/git-show-branches.png" style="border-style:ridge;border-color:#bfbfbf;border-width:1px;width:550px;" /></a><!-- o_ -->   
-  Open the Atom command palette and search for `git checkout checkout` (requires git checkout plugin having been installed).   
<a target="_new" href="screenshots/git-checkout-checkout-search.png"><img src="screenshots/git-checkout-checkout-search.png" style="border-style:ridge;border-color:#bfbfbf;border-width:1px;width:550px;" /></a><!-- o_ -->   
You may also open the checkout dialog directly using the hotkeys `ctrl`+`alt`+`shift`+`c` (or `ctrl`+`opt`+`shift`+`c` on Mac).   
    * The checkout dialog is a list of branches to checkout or switch to. Using the arrow keys, highlight the `custom` entry and hit enter. Now type in the name of the remote branch name. You may find this in GitLab.   
    <a target="_new" href="screenshots/git-checkout-provide-branch.png"><img src="screenshots/git-checkout-provide-branch.png" style="border-style:ridge;border-color:#bfbfbf;border-width:1px;width:550px;" /></a><!-- o_ -->   
    * A notice will display if the checkout was successful. You may then switch between branches using the branch selector in the bottom-right toolbar.   
    <a target="_new" href="screenshots/git-atom-switch-branch.png"><img src="screenshots/git-atom-switch-branch.png" style="border-style:ridge;border-color:#bfbfbf;border-width:1px;width:550px;" /></a><!-- o_ -->   

&#128221; **Note:**  If checking out a remote branch within Atom using the 'git checkout' plugin, ensure you read the directions carefully. Do **_not_** click on the 'custom' branch, use the arrow keys and hit enter and then supply the name of the remote branch you wish to checkout. Lastly, if you make a mistake while typing in the branch name, you will end up creating a new branch with the typo. Be sure to correctly type the branch name.

#### Command Line Branching

Rather than using using the checkout dialogs in Atom, you may also list and checkout remote branches using the git command line tools.

List remote branches:
```
$ git branch -r
  origin/GettingStartedWork
  origin/HEAD -> origin/master
  origin/master
  origin/wendi-5
  origin/user-contributions
```

Checkout a remote branch from the command line.
`git checkout --track origin/wendi-5` after which you may select the branch within Atom.

#### GitLab GUI Editing

You don't have to use Atom for editing. You can hit the `edit` button in GitLab and edit directly, and preview before committing. Note that only repository owners can edit directly this way - otherwise you can create a branch and edit your branch directly.

## Uploading Your Changes

1. Make changes to the files as needed.
-  You can open the Git window by pressing `^`+`(`. Here you view unstaged and staged changes.
    * `Unstaged` means the files are not ready to be committed.
    * `Staged` means the files are ready to be committed.
-  Stage all of the files that you'd like to commit to the branch. This is accomplished by selecting the `+` symbol next to each file. Alternatively, on the top-right of the Git window, there is a `Stage All` button.
-  Commit your changes either within the Git window, or by entering `git commit` in Atom's command palette. Enter a commit message that will help you and others understand what changes were made. Then click `Commit`.
-  Push changes to GitLab by typing `git push` in the command palette, or using Atom's up/down Git arrows located on the bottom-right of the window.

&#128221; **Note:** If you get an error after typing `git push` that says "No upstream branch" open your terminal and navigate to the local copy of the repository. Then type `git push --set-upstream origin name_of_branch`. From then on you should be able to use the command palette to type `git push` or use the up/down arrows on the bottom-right of the window.

## Creating a Merge Request

Merging your branch into the master branch, thereby makes your changes appear in the final version of the files.

You can send a merge request using the GitLab GUI.
1. From the left menu panel in Gitlab, select `Merge Request` then the green `New merge request` button.
- Select your branch in the "Source Branch" side.
  * Target branch will be _master_
  * Click `compare branches`.
- On the next screen the only thing needed is simply:
  * Assign to: *< Project Owner, etc. >*
  * Click `Submit merge request`


## Previewing Changes

When you push a branch, your changes will get built in a "Review Environment"
at http://user-documentation-stf011.granite.ccs.ornl.gov/_review/ and will allow you to click on the name of your branch.

A link to this review environment will be available on the Pull Request page
that is created for your branch. This will allow us to take a quick glance at
changes before we merge them into production.

&#128221; **Note:** Preview sites are a prototype in the workflow. This feature may not always work and is offered as an unsupported convenience.
