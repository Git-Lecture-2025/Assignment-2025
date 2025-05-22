# master

```
git start master
```

# commit-one-file

In this exercise we need to only commit one file, for this we first add the file to staged area and then commit it

```
git add A.txt
git commit -m 'Add A.txt'
```

# commit-one-staged-file

In this exercise we need to commit only one of the staged files, we can do this by unstaging one of the files and commiting the other

```
git restore --staged B.txt
git commit -m 'Add A.txt'
```

# ignore-them

In this exercise we need to set some files to be ignore by git, this can be done using the `.gitignore` file, first we create the `.gitignore` file

```
touch .gitignore
nvim .gitignore
```

Add the following to `.gitignore`

```
*.exe
*.o
*.jar
libraries/
```

This will ignore all files ending with `.exe` `.o` `.jar` and the libraries folder

Now we need to stage the remaining files and commit them
```
git add .
git commit -m "Add .gitignore and file.txt"
```

# chase-branch

We need to merge the current head into the escaped branch which is two commits ahead, we can do this using the merge command

```
git merge escaped
```

# merge-conflict

In this exercise we need to merge current branch into `another-piece-of-work` but the merge will fail due to conflicts, and we will need to manually fix the conflicts and continue the merge

```
git merge another-piece-of-work
nvim equation.txt
```

Edit the file removing the lines added by git and fix the equation
After making the changes stage the file and commit the changes

```
git add equation.txt
git commit -m "Merge another-piece-of-work"
```

# save-your-work

In this exercise we need to fix a bug, we already have partial work so we first need to stash those changes and then fix the bug 

```
git stash
nvim bug.txt
git add bug.txt
git commit -m "fix(bug)"
```

Now we have fixed the bug and can finish our work

```
git stash pop
git add .
git commit -m "Finish work"
```

# change-your-branch

In this exercise we need to include a bugfix that was added a few commits after HEAD, we can do this using the git rebase command

```
git rebase hot-bugfix
```

# remove-ignored

In this exercise we need to stop git from tracking files that we added to `.gitignore` after git started tracking them, we can do this using the `git rm` command 

```
git rm ignored.txt
git commit -m "Remove ignored.txt"
```

# case-sensitive-filename

In this exercise we need to rename a file, we can do this with `git mv` command, we do this instead of just `mv` so that git keeps track of the file

```
git mv File.txt file.txt
git commit -m "Rename File.txt to file.txt"
```

# fix-typo

In this exercise we need to fix a typo we made in the last commit, but we dont want to make a new commit for this, we can mmend the last commit using the `--amend` flag in `git commit` command

```
nvim file.txt
git add file.txt
git commit --amend
```

# forge-date

We can forge the date of a commit using the `--date` flag in `git commit` command, for the format we can see the date in `git log`

```
git commit --date "Sun May 18 18:46:55 1987 +0530" --amend
```

# fix-old-typo

In this exercise we need to fix a typo in a told commit, for this we can use git rebase in interactive mode and edit the commit with the typo
We start the rebase in interactive mode using the `-i` flag

```
git rebase -i
```

Now we edit the commit with the typo by changing the `pick` to `edit`, then we save and close vim
Edit file.txt and fix the typo, then stage the changes and amend the commit

```
git add file.txt
git commit --amend '-S'
```

Now we will continue the rebase using the `--continue` flag, and fix the merge conflicts that arise

```
git rebase --continue
nvim file.txt
git add file.txt
git rebase --continue
```

