# Git Excercises


### Master

```sh
git commit
```

Used to create a commit.

```sh
git push
```

Used to push all commits made.

### Commit-One-File

```sh
git add <file>
```

Registers an untracked file.

### Commit-One-File-Staged

```sh
git restore --staged <file>
```

Unstages a file so it is not committed.

### Ignore-Them

A .gitignore is a file that contains all files and directories to be ignored.

```sh
touch .gitignore
```

To create the file

```sh
nano .gitignore
```

To edit the file in the terminal.

```sh
*.extension
```

Ignores all files with the specific extension (ReGex pattern matching).

```sh
directories/
```

Ignores the `directories` folder.

### Chase-Branch

```sh
git merge escaped
```

Since chase is a direct ancestor this works and nothing bad happens.

### Merge-Conflict

Manually fix the merge conflict and use `git merge` to merge the branch.

### Save-Your-works

```sh
git stash 
```
`git stash` is used to stash my current work and `git stash pop` is used to undo that.

After stashing the current work, fix the bug and make a commit.
Then `pop` the stash and then finish the work before executing the final commit.

### Change-Branch-History

```sh
git rebase hot-<branch>
```

From what I understand, rebase will find the common ancestor, moves my current branch (excluding commits) on top of the branch passed in as the argument, and then reapplies the commits.

Running it once will result in the required diretcory structure.

### Remove-Ignored

```sh
git -rm
```

Is used to remove a file from the git tree.

### Case-Sensitive-Rename

```sh
git -mv
```

Is used to rename a file.

### Fix-Typo

```sh
git commit -am --ammend "fixed typo"
```

After fixing the typo, use the above command to ammend on top if the last commit with the appoproate commit message.

### Forge-Date

```sh
git commit --amend --no-edit --date="1987-01-01T00:00:00"
```

Is used to change the commit date. `--no-edit` ensures nothing about the commit changes.

### Fix-Old-Typo        

```sh
git rebase -i HEAD~2
```

Running the above command will open a commit message wherein we update the message of the second line (since the second last commit) from `pick` to `edit`. 

```sh
pick <last commit>
edit <second last commit> << changed from pick -> edit
```

Now the typo is fixed and the changes are committed.

```sh
git rebase --continue
```

Continues the rebase.
