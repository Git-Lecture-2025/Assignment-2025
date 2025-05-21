# GIT exercises by fracz

## 0. START
```
git verify
```
## 1. commit-one-file
Since none of the files were stages we will first add one and file the commit the changes
```
> git add A.txt
> git commit -m "Change A.txt"
> git verify
```
## 2. commit-one-file-staged
First I checked the name of the files which were staged by running
```
> git status
```
Now i removed A.txt from the staging area by running
```
> git restore --staged A.txt
```
then committed the changes
```
> git commit -m "Change B.txt"
> git verify
```

## 3. ignore-them
First we need to create the .gitignore and add gitignore patterns which will let git know what files or directories to be ignored
```
> touch .gitignore
```
Now we will add the matching patterns for the files
```
> echo "*.exe" >> .gitignore
> echo "*.o" >> .gitignore
> echo "*.jar" >> .gitignore
```
Now we will add the matching patterns for the directories
```
> echo "libaries/" >> .gitignore
```
Then simply add and commit the changes
```
> git add .gitignore
> git commit -m "add .gitignore"
```

## 4. chase-branch
I started by observing the commits in botht eh branches by doing
```
> git checkout <branch> 
> git log --oneline
```
as stated in the question there were 2 more commits in the escaped branch

so i went back to the chase-branch and merged the escaped into it
```
> git checkout chase-branch
> git merge escaped
> git verify
```
## 5. merge-conflict
I started by observing the file in the both the branches.
I ran the folowing being in the merge-conflicts branch
```
> git merge another-piece-of-work 
```
Which showed mege conflicts. In my first try i used the graphical editor to resolve the conflicts and commit the changes. But I wanted to do it the "terminal" way.

So I opened the conflicting file in vim. Modified by the file to match the desired output and save the file. Saved the file and added the files to mark resolution 
```
> git add equation.txt
> git commit -m "Merge another-piece-of-work into merge-conflict"
> git verify
```