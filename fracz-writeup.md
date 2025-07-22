# Exercise0- master  
``` 
git start master
git verify 
```  

# Exercise1- commit-one-file  
```
git start commit-one-file
git add B.txt
```
This is to stage only one of the two files. Then commit it.
```
git commit -m "add file B.txt"
git verify
```

# Exercise2- commit-one-file-staged  
```
git start commit-one-file-staged
git restore --staged A.txt
```
This is to unstage file A.txt. We can also achieve same thing by following command:-
```
git reset A.txt
```
Then we commit the staged files(B.txt in this case)
```
git commit -m "add file B.txt"
git verify
```

# Exercise3- ignore-them
```
git start ignore-them
nano .gitignore
```
This makes a .gitignore file and opens it. Add following lines inside it, to ignore corresponding files/directories.
>*.exe  
>*.o  
>*.jar  
>libraries/ 

Now save and close the editor. Add the file and commit.

```
git add .
git commit -m "add .gitignore file"
git verify
```

# Exercise4- chase-branch  
```
git start chase-branch
git merge escaped
git verify
```
What it does is moves the HEAD pointer on chase-branch to the commit with branch escaped (as chase-branch is an ancestor of escaped).  

# Exercise5- merge-conflict

```
git start merge-conflict
git merge another-piece-of-work
```
This creates a merge conflict in equation.txt  
Remove this by opening equation.txt file using `nano equation.txt` and change file content to:  
>2+3=5  

Then add and commit the changes. Merge conflict will be resolved.

```
git add .
git commit -m "merge merge-conflict with another-piece-of-work"
git verify
```

# Exercise6- save-your-work
```
git start save-your-work
git stash
nano bug.txt
```
Remove bug as stated in the file. Then add file and commit changes.
```
git add .
git commit -m "bugfix"
git stash apply
```
This adds your stashed work back. Now add the line  
>Finally, finished it!  

to bug.txt . Add and commit the changes.

```
git add .
git commit -m "finish work"
git verify 
```
# Exercise7- change-branch-history
```
git start change-branch-history
git rebase hot-bugfix
git verify
```

# Exercise8- remove-ignored
```
git start remove-ignored
git rm ignored.txt
git add .
git commit -m "remove ignore.txt file"
git verify
```

# Exercise9- case-sensitive-filename  
```
git start case-sensitive-filename
git mv File.txt file.txt
git commit -m "rename File.txt -> file.txt"
git verify
```

# Exercise10- fix-typo  
```
git start fix-typo
nano file.txt
```

Change file content to 
>Hello world  

Add file and edit commit message of previous commit using `--amend`
```
git add .
git commit --amend
git verify
```
# Exercise11- forge-data
```
git start forge-date
git commit --amend --no-edit --date="Sat Aug 15 00:00:00 1987 IST"
```
This amends the current commit, with not change in name (`--no-edit`) and changes date to \"15th August 1987\".
```
git verify
```

# Exercise12- fix-old-typo
```
git start fix-old-typo
git rebase -i HEAD~2
```
This opens an interactive rebase editor. `HEAD~2` is used as changes have to be done on previous two commits.  

Inside the rebase editor change the word in front of both commits from **pick** to **edit**. Save and close the editor.  

```
nano file.txt
```
Do the necessary changes and save the file. Add the file to staging area and amend current commit (*correct the commit message in editor as well*)
```
git commit --amend
```
Continue rebase onto next commit.
```
git rebase --continue
```
A merge conflict is created in **file.txt** .  
Open it using `nano file.txt` and change the content to:
>Hello world  
>Hello world is an excellent program.  

Add the file to staging area. Continue the rebase (*it opens commit mesaage window, leave it as it is*)
```
git add .
git rebase --continue
git verify
```