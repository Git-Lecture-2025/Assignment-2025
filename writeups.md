# Exercise 1 : master
To initialize the exercise <br>
First use `git start` for the first commit <br>
Verify the exercise using `git verify`<br><br>

# Exercise 2 : commit-one-file
Check the list of files using `ls`<br>
Add file `A.txt` using git `add A.txt` <br>
Make the commit using `git commit -m "Commit A.txt"`<br>
Verify the exercise using `git verify`<br><br>

# Exercise 3 : commit-one-file-staged
Remove file `B.txt` by using `git reset B.txt`<br>
Then make the commit using `git commit -m "Commit only A.txt"` <br>
Verify the exercise using `git verify`<br><br>

# Exercise 4 : ignore-them
Use `touch .gitignore` to create a `.gitignore` file <br>
Open the file using `nano .gitignore` and add these lines to ignore the files:
>*.exe <br>
*.o <br>
*.jar <br>
libraries/ 

Add the file using `git add .gitignore` and then commit using `git commit -m "Add .gitignore"`<br>
Verify the exercise using git verify<br>
```
 git add .gitignore
 git commit -m "add .gitignore"
 git verify
```
<br>

# Exercise 5 : chase-branch
Start the exercise using `git start chase-branch`<br>
To merge the branches use `git merge escaped`<br>
Verify the exercise using `git verify`<br><br>

# Exercise 6 : merge-conflict
Start the exercise using `git start merge-conflict`<br>
Check if you're on the right branch by the command `git branch`<br>
The branch should be `merge-conflict`<br>
To merge, use `git merge another-piece-of-work`<br>
Open files using
```
 nano README.md
 nano start.sh
 nano equation.txt
```
Manually correct the errors present in these files.<br>
Then use the following commands to add, commit and then verify the exercise.
```
 git add README.md start.sh equation.txt
 git commit -m "Resolved merge conflict"
 git verify
```
<br>

# Exercise 7 : save-your-work
Start the exercise using `git start save-your-work`<br>
To save the previous work and fix the bug first, use `git stash`<br>
Fix the bug manually after opening the file using 
```
 nano bug.txt
 program.txt
```
To get the previous work back, use `git stash pop`<br>
Then add these files using
```
 git add bug.txt program.txt
```
Finally, commit and verify 
```
 git commit -m "Finish the work"
 git verify
```

# Exercise 8 : change-branch-history
To change branch history, use the command `git rebase hot-bugfix change-branch-history`<br>
Verify the exercise using `git verify`<br><br>

# Exercise 9 : remove-ignored
Use the command `git rm --cached ignored.txt` <br>
Commit and verify using
```
 git commit -m "Stop tracking ignored.txt"
 git verify
```

# Exercise 10 : case-sensitive-filename
Use the following commands
```
 git mv File.txt tempname.txt
 git mv tempname.txt file.txt
 git commit -m "Rename File.txt to file.txt with case change"
``` 
 And then verify with
``` 
 git verify
```

# Exercise 11 : fix-typo
Use the following set of commands
```
 git add file.txt
 git --amend
```
Then manually fix the typo and verify.<br><br>

# Exercise 12 : forge-date
Use the command to change the date to 1987:
```
 GIT_COMMITTER_DATE="1987-01-01T12:00:00" git commit --amend --no-edit --date "1987-01-01T12:00:00"
 git log -1 --pretty=full
```
And then verify using
`git verify`
<br>

# Exercise 13 : fix-old-typo
Start with `git rebase -i HEAD~3` to see the previous 3 commits.<br>
Replace "pick" with "edit" in the commit containing `fix-old-typo`<br>
Then to fix the typo, open the file using the command below and fix the typo manually.
```
 nano file.txt
```
Add the file using `git add` <br>
Then use the following commands to amend and then continue the rebase.
```
 git commit --amend
 git rebase --continue
```
Merge the conflict manually and then add the files, continue rebase and verify.
```
 git add file.txt
 git rebase --continue
 git verify
``` 