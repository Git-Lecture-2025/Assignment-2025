# master
cloned exercises using the given how to start code and ran
```
git start master
```
afterwards
```
git verify
```

# commit-one-file
first added B.txt in the staging area using 
```
git add B.txt
```
and commited it using 
```
git commit -m "Commit B.txt"
```
ensuring only single file gets commmited as only one file was staged

# commit-one-file-staged
reset the entire stage using 
```
git reset
```
and added A.txt to the staging area using
```
git add A.txt
```
and commited
```
git commit -m "only A.txt commit"
```

# ignore-them
created a file using 
```
touch .gitignore
```
and added the extension for unwanted files using 
```
echo "*.exe" >> .gitignore
echo "*.o" >> .gitignore
echo "*.jar" >> .gitignore
echo "libraries/" >> .gitignore
```
added the file to stage and commited it
``` 
git add .gitignore
git commit -m "commit .gitignore"
```

# chase-branch
merged the current branch with latest changes using 
```
git merge escaped
```

# merge-conflict
tried merging another-piece-of-work
```
git merge another-piece-of-work
```
ran into he conflict
```
Auto-merging equation.txt
CONFLICT (content): Merge conflict in equation.txt
Automatic merge failed; fix conflicts and then commit the result.
```
went into the file to see the conflict 
```
cat equation.txt
```
the issue
```
<<<<<<< HEAD
2 + ? = 5
=======
? + 3 = 5
>>>>>>> another-piece-of-work
```
fixing the issue
```
echo 2+3=5 > equation.txt
```
adding the changes and commiting them
```
git add equation.txt
git commit -m "resolve merge conflict"
```

# save-your-work
```
git stash
```
now fixing the bug
```
nano bug.txt
```
fixed the bug commit changes
```
git add bug.txt
git commit -m "fix bug"
git stash pop
```
and added the final line and commited the changes
```
echo "Finally, finished it!" >> bug.txt
git add .
git commit -m "Finish my work"
```

# change-branch-history
rebasing would help
```
git rebase hot-bugfix
```

# remove-ignored
```
git rm ignored.txt
```
commiting changes
```
git add .
git commit -m "remove ignored.txt"
```

# case-sensitive-filename
```
git mv File.txt file.txt
git commit -am "change file name"
```

# fix-typo
```
nano file.txt
```
fixed the typo
``` 
git commit --amend
```
fixed the typo in the commit message


# forge-date
used the date flag 
```
git commit --amend --date="1987-08-03"
```

# fix-old-typo
```
git rebase -i HEAD~2
```
out of two pick changed the one with typo to edit
then fixed the typo in the file 
```
git add file.txt
git rebase --continue
```
fixed the merge conflict that arised and continued rebasing
```
git rebase --continue
```
fixed the typo in the commit message
