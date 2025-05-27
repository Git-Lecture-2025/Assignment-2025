# Git exercises
## exercise 1 Master 
use 
`git start
git verify`

## exercise 2 commit-one-file
use 
`git add A.txt   
git commit -m "add A.txt"
git verify`

## exercise 3 commit-one-file-stagged
use
`git reset HEAD A.txt 
git commit -m "destage one file"
git verify`
 here the git reset removes the unwanted file and then after git commit will commit the remaining files 

 ## exercise 4 ignore them
 use this to create a git ignore
` *.exe
*.o
*.jar
libraries/`

after that use 
`git add .
git commit -m "commit useful files"
git verify`

## exercise 4 chase branch
use 
`git checkout chase-branch
git merge escaped
git verify`

## exercise 5 merge conflict

use
`git merge another-piece-of-work
git add equation.txt`
then commit and verify 
`git commit -m "merge and resolve"
git verify`

## exercise 6 save your work
`git stash`
Fix bug in bug.txt
`git add bug.txt
git commit -m "fix bug"`
to get all the previous work we use the git stash 
`git stash pop
git add .
git commit -m "finish work"
git verify`

## exercise 7 change branch history
use 
`git checkout change-branch-history
git rebase hot-bugfix
git verify`

## exercise 8 remove ignored
use 
here rm means remove file 
`git rm --cached ignored.txt
git commit -m "remove ignored.txt"
git verify`

## exercise 9 case sensitive filename 
use
`git mv File.txt file.txt
git commit -m "rename file"
git verify`

## exercise 10 fix typo
use 
here we should Edit file.txt to fix the typo

`git add file.txt
git commit --amend
git verify
`
## exercise 11 forge date
use 
`
git commit --amend --date="whatever the date you want "
git verify
`

## execises 12 fix old typo
use 

`
git rebase -i HEAD~2
`
for this case we shall Change 'pick' to 'edit' for the commit we want to fix
`
git add file.txt
git commit --amend
`
fix the typo and then run 
`
git rebase --continue
git verify
`
