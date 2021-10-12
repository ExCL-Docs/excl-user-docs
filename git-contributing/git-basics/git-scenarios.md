# Git Scenarios

[ExCl](https://docs.excl.ornl.gov) → [User Documentation](../../) → [Contributing](https://github.com/ORNL-ExCL/excl-user-docs/tree/5b0a2bac08c6595857ffaa414e0a315a8fdfa27c/CONTRIBUTE.md) → [Git Scenarios](git-scenarios.md)

## Git Scenarios

This document includes common Git scenarios and how to deal with them.

### Updating a branch with new content from the master branch

If you have been working on a development branch for a while you might like to update it with the most recent changes from the master branch. There is a simple way to include the updates to the `master` branch into your `development` branch without causing much chaos.

First, checkout your development branch. Then, perform a merge from `master` but add the "no fast forward" tag. This will ensure that `HEAD` stays with your `development` branch.

```bash
git checkout development
git merge --no-ff master
```

Resolve any conflicts and push your changes.

### Configuring Git: local vs global

When you set up Git with the `git config --global ...` commands, you are telling your local machine that this is the set of credentials that should be used across your directories. If you have multiple projects for which you need unique credentials, you can set a particular project folder with different Git credentials by changing `global` to `local`. For example, you may contribute to projects in GitHub and GitLab. You can navigate to the local repository and set local configuration parameters. See below:

```bash
cd projects/

ls
GitHub/   GitLab/

cd GitHub/
git config --local user.name "Jane Doe"
git config --local user.email "doej@example.com"
```

Now, the machine will use global configurations everywhere except for the `/project/GitHub/` repository.

### Undoing a change

**Changes since your last commit**

You have previously committed some files and now you've edited a file and saved your changes. However, you now decide you do not want keep the changes that you've made. How can you revert it back to the way it was at your last commit?

```bash
$ git status
Changes not staged for commit:
    (use "git add <file>..." to update what will be committed)
    (use "git checkout -- <file>..." to discard changes in working directory)

      modified:   README.md
```

The `git status` command output provides a method for discarding changes since your last commit.

```bash
$ git checkout -- README.md
$ git status
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)
    renamed:    README.md -> read-me
```

📝 **Note:** Before using the above commands to reverse your changes, be sure you do not want to keep them. After the commands are run, the file(s) will be overwritten and any uncommitted changes will not be recoverable.

**Reverting to a previous commit**

If you are working on a new feature and after a commit you realize that you have introduced a catastrophic bug, you can use `git reset ac6bc6a2` (each commit has a unique identification number). This command will change where the `HEAD` pointer is located. For example, if you are on the `master` branch and have submitted three new commits, the `HEAD` points to your most recent commit. Using the `git reset ---` command will keep the information in the recent commits, but `HEAD` will be moved to the specified commit.

To find the unique identification number of the commits in your branch, type `git log --pretty=format:"%h %s" --graph` to provide a list of recent commits as well as a visual graph of changes.

**Amending a commit**

Let's say that you have just completed several changes, staged (added), and committed them. As you look at one file, you see a typo. You could simply fix the typo, add, and commit again, or you could use the `--amend` tag so that the new changes (your typo fix) can be included in your previous commit. Using this can keep your commit history uncluttered by removing commit messages such as "forgot to add a file" or "fixed a typo." Here is an example of a forgotten file amended commit:

```bash
git commit -m 'initial commit'
git add forgotten_file
git commit --amend
```

A commit message prompt appears and you can either keep the original commit message or modify it.

**Undoing a merge**

Perhaps you thought you had checked out your development branch but you were, in fact, on the `master` branch. Then you merged a `topic` branch into `master` by mistake. How do you undo the merge?

If you just want to take a step back to before you entered the `merge` command, you can use `git merge --abort`. This is usually a safe command as long as you do not have any uncommitted changes.

If you need something a little more robust, you can use `git reset --hard HEAD`. This command is used to perform a "start over" in your repository. It will reset your repository to the last commit.

### Collaboration Etiquette

**Commit messages**

When multiple people are working in the same repository, the number of commits can be anywhere between a few or several thousands depending on the size of your development team. Using clear, descriptive commit messages can help "integration managers" merge content and, perhaps more importantly, search for and find commits that have introduced a bug.

Another recommendation by the author of "Pro Git" says, "try to make your changes digestible — don’t code for a whole weekend on five different issues and then submit them all as one massive commit on Monday."

### I do not want Git to track a particular file/directory

If there are files/folders in your repository that you do not want Git to track, you can add them to a `.gitignore` file. Here is an example `.gitignore`:

```bash
# ignore all .a files
*.a

# but do track lib.a, even though you're ignoring .a files above
!lib.a

# only ignore the TODO file in the current directory, not subdir/TODO
/TODO

# ignore all files in the build/ directory
build/

# ignore all .pdf files in the doc/ directory and any of its subdirectories
doc/**/*.pdf
```

#### Works Cited

* Chacon, Scott, and Ben Straub. _Pro Git: Everything You Need to Know About Git._ Apress, 2nd Edition (2014).
