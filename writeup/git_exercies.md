## chase-branch
* Here we need to point the head of the chase-branch to that of the escaped branch. For this, we need to use the git reset and git log command.
* First, we check the commit hash of the escaped branch by running
```
git log
```
* Then, we point the head of the chase-branch to that by
```
git reset --soft "commit hash"
```
Note, we use the soft argument just to change the head of the current branch to the particular commit.


## commit-one-file
* In this exercise, we have two upstaged files, and we have to commit only one of them.
The trick is to use the add command with the file path as an argument so only that file is moved to the staging area.

```
git add ./B.txt
```

* On running this command, the *B.txt* is added to the staging area, and we can be committed with

```
git commit
```


## commit-one-file-staged
* In this exercise, we have two staged files, and we have to commit only one of them.

The trick is to use the restore command with the file path as an argument so that that file is removed from the staging area.

```
git restore --staged B.txt
```

* On running this command, the *B.txt* is removed from the staging area, and we can commit file *A.txt*

```
git commit -S -m "add A.txt"
```


## ignore-them
Here we have to ignore some types of files and directories.
* For this, we use the .gitignore file, which keeps track of which files and directories should not be tracked by git.

Create and edit .gitignore
```
nvim .gitignore
```
Note, we use *.gitignore* so that it's a hidden file.

* Next, we use regular expressions to exclude all the files we don't want to track by adding
```
*.exe
*.o
*.jar
libraries/*
```

** means any character or sequence, so for example, *.exe would mean any file name with .exe at the end will be ignored.

### merge-conflict
We need to merge `another-piece-of-work` into `merge-conflict`. So we switch to the `merge-conflict` branch and try running 
```
git merge another-piece-of-work
```
Here we get a merge conflict in equation.txt file 
```
<<<<<<< HEAD
2 + ? = 5
=======
? + 3 = 5
>>>>>>> another-piece-of-work
```
It can be resolved by changing the value between the <<<<<<< and >>>>>>> to the desired value.

```
git add .
git commit
```

## save-your-work

First, we store our current mess in a stack with `git stash`, which takes us back to the last commit.
Then, we fix the bug in `bug.txt` by removing the line 

```
THIS IS A BUG - remove the whole line to fix it.
```

```
git add .
git commit -m "bug fix"
```
Here, the bug is fixed, and we can get our stashed work by git apply and apply the change. 

```
git add .
git commit -m 'save-your-work'
```

## change-branch-history
Here, we need to rebase the hot-bugfix.
```
git rebase hot-bugfix
```

## remove-ignored
Here, we need to delete the cache so that we can add the files to the staging area with the new .gitignore rules.
```
git rm -r --cached .
git add .
```

## case-sensitive-filename
Here, since we have committed the change, we need to revert back to the last commit without losing the changes, then change the file name and recommit.
```
git reset Head^
git add .
```
## fix-typo 
Here, we simply need to fix the typo and then use the --amend flag to put the changes in the last commit.
```
git commit --amend

```

## forge-date 
Here, we just use the command for that functionality. 
```
$> git commit --amend --no-edit --date="1987-08-03"
```
## fix-old-typo 
Here, we need to go and fix the old typo in both the commit message and the file.
We do this by going into the git rebase interactive mode.
```
git rebase -i
```
How we change the prefix of the wrong commit from pick to edit (which means the rebase will stop here and we can change stuff here).
Then, we fix the typo in the file and then amend it to the commit.
After this, we try git rebase continue, which gives a merge-conflict, then we can solve the conflict and
```
git add .
git rebase --continue
```
