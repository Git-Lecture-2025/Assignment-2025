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

## 6. save-your-work
I started by staching my changes
```
> git stash
```
Now once i had a clean directory
I removed the bug in bug.txt and commited the changes
```
> git add bug.txt
> git commit -m "Fix bug in bug.txt"
```
I now wanted my old changes so that i can finish it
```
> git stash apply
```
Made the required changes and then commited
```
> git add .
> git commit -m "Finish working in save-your-work"
> git verify
```

## 7. change-branch-history
I want to encorporate changes from branch into mine so I can try merging it into my branch. But this would create a merge commit and the final branch structure won't look as asked in the question. 
So now I have to resort to the second option which is rebasing change-branch-history to the hot-bugfix base 
```
> git rebase hot-bugfix
> git verify
```

## 8. remove-ignored
Git was already tracking the file so we have to remove it from the index, so that it doesnt track the changes already made into it

```
> git rm --cached ignored.txt
> git add .
> git commit -m "Added ignore.txt to .gitignore properly "
> git verify
```

## 8. case-sensitive-filename
So initially my idea was to just do 
```
cp File.txt file.txt
```

but since windows won't let me do it i create a new file a.txt and used it as temporary file.

File -> a \
a -> file 

Finally delete the unnecessary files
```
> cp File.txt temp.txt
> rm File.txt
> cp temp.txt file.txt
> rm temp.txt

> git add .
> git commit -m "Rename File.txt to file.txt"
> git verify
```

But then upon seeing the hint box after submission I got to know the faster way

```
> git mv File.txt file.txt
> git add .
> git commit -m "Rename File.txt to file.txt"
```

## 9. fix-typo
Fix a type and don't let anyone know. 
It was clear that I have to use --amend flag since changes were to be made in the same commit

After fixing the typo
```
> git add .
> git commit --amend
```
which opened up the commit message in editor. after editing the commit message 
```
> git verify
```

## 10. forge-date
Now in the first i thought may be change the date in the comment editor will help but it didn't change it so thought may just -m there must be some flag for date also. 
-d didn't work. 
on doing 
```
> git help commit
```
there was a date flag so i used it
```
> git commit --amend --date="Fri Mar 9 08:30:24 1987 +0100"
```

## 11. fix-old-typo
This one took by far the most amount of time till now.

I tried i going to the commit by it's hash and ammending it but now the hash is chaged so it went into a detached state which did no good. 

Upon seeing the hint of using git rebase in interactive mode I first spent time learning how to use it. 

Here is what is did

First i took a look at the commits and got the commit hash of the previous commit from which i wanted to rebase.

```
> git rebase <hash>
or
> git rebase HEAD~2
```
then changed the type of both the commits to edit (previously pick)

and closed the file. 
Made the changes and ran
```
> git add .
> git commit --amend
```
and then edited the commit message
```
> git rebase --continue
```
Same drill as above, made the changes 
```
> git add .
> git commit --amend
> git rebase --continue

> git verify
```
