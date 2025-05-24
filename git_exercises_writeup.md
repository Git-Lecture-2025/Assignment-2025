# 1. master
Initialise the exercise<br>
Use `git start` to make the initial commit<br>
Verify using `git verify`<br><br>


# 2. commit-one-file
Add one file using `git add A.txt`<br>
Commit using `git commit -m "commit message"`<br>
Verify using `git verify`<br><br>


# 3. commit-one-file-staged
Remove files using `git reset`<br>
Add file using `git add A.txt`<br>

The same can be achieved by resetting one file by `git reset B.txt` to remove it from the staging area.

Commit using `git commit -m "commit message"`<br>
Verify using `git verify`<br><br>


# 4. ignore-them
Create a `.gitignore` file using `touch .gitignore` and write the following four lines to ignore files:
>*.exe <br>
*.o <br>
*.jar <br>
libraries/ 

Add `.gitignore` file, commit and verify:
```
git add .gitignore
git commit -m "add .gitignore"
git verify
```
<br>


# 5. chase-branch
Use `git merge escaped` to merge<br>
Verify with `git verify`<br><br>


# 6. merge-conflict
`git merge another-piece-of-work` will result in conflict<br>
Manually fix the `equation.txt` file

```
git add equation.txt
git commit -m "merge another-piece of work"
git verify
```
<br>

# 7. save-your-work
Use `git stash` to save progress<br>
Fix the bug manually
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
<br>

# 8. change-branch-history
Use `git rebase hot-bugfix change-branch-history`<br>
Verify with `git verify`<br><br>


# 9. remove-ignored
```
git rm ignored.txt
git commit -m "untrack file"
git verify
```
<br>

# 10. case-sensitive-filename
Rename `File.txt` to `file.txt`
```
git mv File.txt file.txt
git commit -m "rename file"
git verify
```
<br>

# 11. fix-typo
Manually edit `file.txt`<br>
Add file to staging area and amend the commit:
```
git add file.txt
git commit --ammend -m "Add Hello world"
git verify
```
<br>


# 12. forge-date
```
git commit --amend --date=1987 -m "add work.txt"
git verify
```
<br>


# 13. fix-old-typo
Access history with `git rebase -i`<br>
Replace _pick_ with _edit_ in the first commit<br>
Make changes in `file.txt`<br>
Add the file using `git add file.txt`<br>
Edit the commit message with `git commit --amend '-S' -m "Add Hello world"`<br>
Fix merge conflict manually
```
git add file.txt
git rebase --continue
git verify
```