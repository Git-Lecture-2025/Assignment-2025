# Exercise 1

 I initialized the exercises by writing
 
 `git start`

 Then completed the first exercise by using:
 
 `git verify`

 # Exercise 2

the exercise requires us to commit just one exercise, so i added just one file, commited and verified using

`git add A.txt`
`git commit -m "commit A.txt`
`git verify`

# Exercise 3
added both files using `git add .`
commited just A.txt using `git commit A.txt -m "commit only A.txt"`
verified using `git verify`

# Exercise 4
created a .gitignore file with contents 
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



