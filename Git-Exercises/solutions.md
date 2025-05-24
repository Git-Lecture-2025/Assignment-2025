# Exercise 1

 Initialize the exercises by writing
 
 `git start`

 Complete the first exercise using:
 
 `git verify`

 
# Exercise 2

Add just one file, commit and verify using:

`git add A.txt`
`git commit -m "commit A.txt`
`git verify`

# Exercise 3
Add both files using `git add .`

Commit just A.txt using `git commit A.txt -m "commit only A.txt"`

Verify using `git verify`

# Exercise 4
create a .gitignore file with contents 
 ```
 *.exe
 *.o
 *.jar
 libraries/
 ```

 now add, commit and verify using:

 `git add .gitignore`
 `git commit -m "ignore mentioned files"`
 `git verify`

 # Exercise 5
 To merge chase with escaped, use: 
 `git merge escaped`
 verify using `git verify`

 # Exercise 6
 the merge conflict arises after `git merge another-piece-of-work` in the equation.txt file

 manually solve the equation to get 2+3=5

 then add, commit and verify using
 `git add equation.txt`
 `git commit -m "merge another-piece-of-work"`
 `git verify`


# Exercise 7
use `git stash` to stash current work

fix the bug by removing the required line in bug.txt

`git add bug.txt`
`git commit bug.txt`

use `git stash apply` to bring back unfinished work 

make changes in bug.txt, then add, commit and verify using
`git add .`
`git commit -m "bug fixed"`
`git verify`

# Exercise 8
bring head to change-branch-history using 
`git checkout change-branch-history`

rebase using `git rebase hot-bugfix`

`git verify`

# Exercise 9
remove file using `git rm ignored.txt`

commit, verify using 

`git commit -m "untrack ignored"`
`git verify`

# Exercise 10
rename the file using
`git mv File.txt file.txt`
commit, verify using
`git commit -m "change file name"`
`git verify`

# Exercise 11
manually edit file.txt

add the change to stage using `git add file.txt`

amend this change to last commit using 
`git commit --amend`

`git verify`

# Exercise 12
to amend the date, use:
`git commit --amend --date="1987" --no-edit`
`git veriify`

# Exercise 13
use interactive rebasing and ccess last 2 commits using
`git rebase -i HEAD~2`
replace pick with edit for the commit you want to edit.

manually edit file.txt and change from wordl to world

`git add file.txt`
`git commit --amend -S`
`git rebase --continue`

resolve merge conflict in file.txt manually, then add, continue rebasing and verify using

`git add file.txt`
`git rebase --continue`
`git verify`