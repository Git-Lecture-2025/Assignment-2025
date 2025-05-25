# (1) MASTER
Use `git start` 
then `git verify` 


# (2) COMMIT ONE-FILE
Add one file using `git add A.txt`<br>
then commit with `git commit -m "commit message"`<br>
finally, `git verify`<br><br>


# (3) COMMIT-ONE-FILE-STAGED
What i did- unstage one file then commit the other file.
`git reset` to remove one file<br>
Add file using `git add A.txt`<br>
Commit the added file using `git commit -m "Added A.txt"`<br>


# (4) IGNORE-THEM
Create a `.gitignore` file using `touch .gitignore`
Added the following to the `.gitignore` file:
>*.exe <br>
*.o <br>
*.jar <br>
libraries/ 

Stage,commit and finally verify:
```
git add .gitignore
git commit -m "add .gitignore"
git verify
```
<br><br>


# (5) CHASE-BRANCH
`git merge escaped` 
<br><br>

# (6) MERGE-CONFLICT
gave rise to a merge conflict (by merging current branch with another piece of work" then manually fixed it.
`git merge another-piece-of-work` <br>
Manually fix the `equation.txt` file on text editor

Stage,commit and finally verify:
```
git add equation.txt
git commit -m "merge another-piece of work"
git verify
```
<br><br>

# (7) SAVE-YOUR-WORK
run
`git stash`
manually fix the bug, then run
```
git add bug.txt
git commit -m "fix bug"
```
reapply previous changes using
`git stash pop`
make further updates to bug.txt, then run
```
git add .
git commit -m "update files"
git verify
```
<br><br>

# (8) CHANGE-BRANCH-HISTORY
```
git rebase hot-bugfix
git verify
```


# (9) REMOVE-IGNORED
If a file was tracked before being added to .gitignore, we can use the following to stop tracking it:
```
git rm ignored.txt
git commit -m "Remove ignored.txt"
git verify
```
<br><br>

# (10)CASE-SENSITIVE-FILE-NAME
To rename a file by changing only its letter casing (e.g., File.txt to file.txt), we can use:
```
git mv File.txt file.txt
git commit -m "rename file"
git verify
```
<br><br>

# (11) FIX-TYPO
After manually editing file.txt, stage the changes and amend the last commit using:
```
git add file.txt
git commit --amend -m "Add Hello world"
git verify
```


# (12) FORGE-DATE
```
git commit --date "Sun May 25 00:49:23 1987 +0530" --amend
```
<br>

