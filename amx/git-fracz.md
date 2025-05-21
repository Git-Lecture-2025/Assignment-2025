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