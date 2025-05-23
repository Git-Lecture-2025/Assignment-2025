# 1st exercise
In the 1st exercise I used the following commands
```shell
$ git start
```
which creates a file.
Then we need to run
```shell
$ git verify
```
That checks whether I have correctly run the commands such as cloning and thus passes with the following result


> Verifying the master exercise. > Hold on...
> Exercise: master        
> Status: PASSED

# 2nd Exercise
In the 2nd exercise the main task is to commit a single file from the 2 files given
The two files are 
> A.txt

> B.txt

So we need to run the following commands
```shell
$ git add A.txt
```
Which helps in adding a single file
```shell
git -s -S -m "add a single file"
```
Which helps in commiting the file which was stages to commit

Then we need to run
```shell
$ git verify
```
That checks whether I have correctly run the commands such as cloning and thus passes with the following result


> Verifying the master exercise. > Hold on...       
> Status: PASSED

# 3rd Exercise
Here there are 2 files that were already stages to commit 
Those files are
> A.txt

> B.txt

So now to uncommit or untrack a single file the command that needs to be used is 
```shell
$ git restore --staged A.txt
```
This will unstage A.txt and now only B.txt is staged so we can simply run
```shell
git -s -S -m "add a single file"
```
Which helps in commiting the file which was stages to commit

Then we need to run
```shell
$ git verify
```
That checks whether I have correctly run the commands such as cloning and thus passes with the following result


> Verifying the master exercise. > Hold on...     
> Status: PASSED

# 4th Exercise
In this exercise I was asked to create a **.gitignore file**
This will help me to stage and commit all files at once while automatically removing certain extensions and directories that are not required

Then simply rest was the same
```shell
git -s -S -m "add a single file"
```
Which helps in commiting the file which was stages to commit

Then we need to run
```shell
$ git verify
```
That checks whether I have correctly run the commands such as cloning and thus passes with the following result


> Verifying the master exercise. 
Hold on...        
> Status: PASSED

# 5th Exercise
In this exercise there were 2 branches
> chase-branch(where the HEAD is present)
> escaped
The escaped branch was **2 commits ahead** of the chase-branch
hence the command that was required
```shell
$ git merge escaped
```
Which helped the chase-branch to also gain those 2 commits that were present in escaped branch
Then we need to run
```shell
$ git verify
```
That checks whether I have correctly run the commands such as cloning and thus passes with the following result


> Verifying the master exercise. > Hold on...      
> Status: PASSED

# 6th Exercise
In this exercise there was a merge conflict between 2 branches that are
> merge-conflict

> another-piece-of-work

Thus when we run
```shell
$ git merge another-piece-of-work
```
Then I get a merge confilct that need to manually corrected than finally becomes
> 2+3=5

Thus then we just need to run
```shell
$ git add equation.txt
$ git commit -m "some changes"
$ git merge another-piece-of-work
```
The command run without any error showing that the error has been corrected

```shell
$ git verify
```
That checks whether I have correctly run the commands such as cloning and thus passes with the following result


> Verifying the master exercise. > Hold on...        
> Status: PASSED


# 7th Exercise
In this exercise we mainly learnt the usage of git stash
So firstly we need to run the command
```shell
$ git stash -u
```
Which removes all the recent untracked and uncommited changes in the file and saves it with a hex code so that we go to that previous commit state that we wanted

> No remove the bug line and commit as without that it won't let you bring back your previous uncommitted modifications

```shell
$ git commit -m "Fix the bug in bug.txt"
```

Now just run the command
```shell
$ git stash apply
```
So that all the new and the old changes(that were stashed) are merged together in the file

Now just add a new line saying

> Finally, finished it!

just simply run
```shell
$ git add .
$ git commit -m "Finally, finished it"
```

Just simply run
```shell
$ git verify
```
That checks whether I have correctly run the commands such as cloning and thus passes with the following result


> Verifying the master exercise. > Hold on...        
> Status: PASSED

# 8th Exercise
In this exercise we have 2 branches
> change-branch-history

> hot-bugfix

So now the motive is to shift the commits of hot-bugfix to chnage-branch-history so in this case we run
```shell
$ git rebase hot-bugfix
```

```shell
$ git verify
```
That checks whether I have correctly run the commands such as cloning and thus passes with the following result


> Verifying the master exercise. > Hold on...        
> Status: PASSED

# 9th Exercise
In this exercise we had to remove the ignored.txt which can be done using the command
```shell
$ git rm ignored.txt
```
Then an important task is to commit that change as well as till then it will not be taken care by git
```
$ git commit -s -S -m "delete some files"
```
```shell
$ git verify
```
That checks whether I have correctly run the commands such as cloning and thus passes with the following result


> Verifying the master exercise. > Hold on...        
> Status: PASSED

# 10 Exercise
Here we needed to change the filename so in this case we will run the following command
```shell
$ git mv File.txt file.txt
```
So now it will change the name and also stage it for commit as well
Then simply commit it
```shell
$ git commit -s -S -m "change name of file"
```
```shell
$ git verify
```
That checks whether I have correctly run the commands such as cloning and thus passes with the following result


> Verifying the master exercise. > Hold on...        
> Status: PASSED

# 11 Exercise
Here you need to firstly bring the changes in the file.txt which is converting **wordl** to **world**
Now when you run the following command
```shell
$ git add file.txt
```
So that the changes that you made is staged for commit
Now run
```shell
$ git commit --amend
```
This will not only bring the staged changes but now you can also change that commit message so it take care of both these changes in that very same commit

```shell
$ git verify
```
That checks whether I have correctly run the commands such as cloning and thus passes with the following result


> Verifying the master exercise. > Hold on...        
> Status: PASSED

# 12 Exercise
In this exercise we need to use data manipulation of the **git commit --amned** command in the following way
```shell
$ git commit --amend --no-edit --date="Tue May 20 11:40:16 1987 +0530"
```
This will change the date without changing the commit message

```shell
$ git verify
```
That checks whether I have correctly run the commands such as cloning and thus passes with the following result


> Verifying the master exercise. > Hold on...        
> Status: PASSED

# 13 Exercise
