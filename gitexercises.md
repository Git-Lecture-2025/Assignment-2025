# master

Run `git start master`

# commit-one-file

Run `git add A.txt` to only add `A.txt`

Run `git commit -m 'Add A.txt'` to commit added file 

# commit-one-staged-file

Run `git restore --staged B.txt` to unstage B.txt

Run `git commit -m 'Add A.txt'` to commit

# ignore-them

Run `touch .gitignore` to create .gitignore file

Run `nvim .gitignore` to edit it

Add the following to .gitignore

```
*.exe
*.o
*.jar
libraries/
```

This will ignore all files ending with `.exe` `.o` `.jar` and the libraries folder

Run `git add .` to stage all files in the current folder

Run `git commit -m "Add .gitignore and file.txt"` to commit the changes

# chase-branch

Run `git merge escaped` to merge HEAD into escaped

# merge-conflict

Run `git merge another-piece-of-work` to start the merge

Run `nvim equation.txt` to edit the file with the merge conflicts

Edit the file removing the lines added by git and fix the equation

Run `git add equation.txt` to stage the modified file 

Run `git commit -m "Merge another-piece-of-work"` to commit the changes

# save-your-work

Run `git stash` to stash the changes

Run `nvim bug.txt` to edit the file

Fix the bug in bug.txt

Run `git add bug.txt` to stage bug.txt

Run `git commit -m "fix(bug)"` to commit the bugfix

Run `git stash pop` to get back your changes before the bugfix

Add the required line at the end of bug.txt

Run `git add .` move all files to staged area

Run `git commit -m "Finish work"` to commit the completed work

# change-your-branch

Run `git rebase hot-bugfix` to rebase your HEAD to hot-bugfix

# remove-ignored

Run `git rm ignored.txt` to stop git from tracking it

Run `git commit -m "Remove ignored.txt"` to commit the removal

# case-sensitive-filename

Run `git mv File.txt file.txt` to rename File.txt to file.txt

Run `git commit -m "Rename File.txt to file.txt"` to commit the changes

# fix-typo

Run `nvim file.txt` and fix the typo

Run `git add file.txt` to stage the file

Run `git commit --amend` to amend the previous commit and fix the typo in the commit message

# forge-date

Run `git commit --date "Sun May 18 18:46:55 1987 +0530" --amend` to edit the date of a previous commit 

# fix-old-typo

Run `git rebase -i` to start interactive rebase

Change pick to edit for the old typo commit, write and exit

Edit file.txt and fix the typo

Run `git add file.txt` to stage the changes

Run `git commit --amend '-S'` to amend the typo commit 

Run `git rebase --continue` to continue the rebase, it will fail due to merge conflicts

Edit file.txt and manually fix the merge conflicts

Run `git add file.txt` to stage the changes

Run `git rebase --continue` to complete the rebase

