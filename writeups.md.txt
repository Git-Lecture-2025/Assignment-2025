# (1) MASTER
Initialise the exercise<br>
Use `git start` <br>
Use `git verify` to verify<br><br>


# (2) COMMIT ONE-FILE
Add one file using `git add A.txt`<br>
then commit with `git commit -m "commit message"`<br>
finally, `git verify`<br><br>


# 3. COMMIT-ONE-FILE-STAGED
use `git reset` to remove one file<br>
Add file using `git add A.txt`<br>
Commit using `git commit -m "commit message"`<br>
finally, `git verify`<br><br>


# 4. IGNORE-THEM
Create a `.gitignore` file using `touch .gitignore` and write the following four lines to ignore files:
>*.exe <br>
*.o <br>
*.jar <br>
libraries/ 

Then stage,commit and finally verify:
```
git add .gitignore
git commit -m "add .gitignore"
git verify
```
<br>


# (5) CHASE-BRANCH
`git merge escaped` to merge<br>
Verify.<br><br>


# (6) MERGE-CONFLICT
`git merge another-piece-of-work` will give rise to a conflict<br>
Manually fix the `equation.txt` file

Then stage,commit and finally verify:
```
git add equation.txt
git commit -m "merge another-piece of work"
git verify
```
<br><br>

# (7) SAVE-YOUR-WORK
Save progress using `git stash` <br>
then, Fix the bug manually
```
git add bug.txt
git commit -m "fix bug"
```
Use `git stash pop` to reapply previous work<br>
Update `bug.txt` <br>
Use `git add .` to add all files to staging area<br>
Commit and verify
```
git commit -m "update files"
git verify
```
<br><br>

# (8) CHANGE-BRANCH-HISTORY
`git rebase hot-bugfix change-branch-history`<br>
Verify.<br><br>


# (9) REMOVE-IGNORED
```
git rm ignored.txt
git commit -m "untrack file"
git verify
```
<br><br>

# (10)CASE-SENSITIVE-FILE-NAME
Rename `File.txt` to `file.txt`
```
git mv File.txt file.txt
git commit -m "rename file"
git verify
```
<br><br>

# (11) FIX-TYPO
Manually edit `file.txt`<br>
stage file, amend, commit:
```
git add file.txt
git commit --ammend -m "Add Hello world"
git verify
```
<br>


# (12) FORGE-DATE
```
git commit --amend --date=1987 -m "add work.txt"
git verify
```
<br>

