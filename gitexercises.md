# GitExercises by fracz

### master

Just verify to solve the current level.

```
$ git verify
```

### Commit one file

> There are two files created in the root project directory - A.txt and B.txt. The goal is to commit only one of them.

To commit only one file, stage only a single file.

```
$ git add A.txt
$ git commit -m "Commit A.txt"
$ git verify
```

### Commit one file of two currently staged

> There are two files created in the root project directory - A.txt and B.txt. They are both added to the staging area. The goal is to commit only one of them.

So here we have staged two files, but only need to commit one. To do this we need to reset the staged files and then proceed the staging with the file we need to commit.

```
$ git reset
$ git add A.txt
$ git commit -m "Commit A.txt"
$ git verify
```

### Ignore unwanted files

> It is often good idea to tell Git which files it should track and which it should not. Developers almost always do not want to include generated files, compiled code or libraries into their project history.
>
> Your task is to create and commit configuration that would ignore:
>
> all files with exe extension
> all files with o extension
> all files with jar extension

So there is a `.gitignore` file which contains file patterns which need to be ingored during the staging process. Simply create a `.gitignore` file and add the following to them.

```
*.exe
*.o
*.jar
libraries/
```

Then,

```
$ vim .gitignore
$ git add .
$ git commit -m "Add files"
$ git verify
```

### Chase branch that escaped

> You are currently on chase-branch branch. There is also escaped branch that has two more commits.
> 
> ```
>     HEAD
>      |
> chase-branch        escaped
>      |                 |
>      A <----- B <----- C
> ```
> 
> You want to make chase-branch point to the same commit as the escaped branch.
> 
> ```
>                   escaped
>                      |
>    A <----- B <----- C
>                      |
>                 chase-branch
>                      |
>                     HEAD
> ```

Ok, so we need to merge two branches together so that they point at the same branch ,ie, we need to merge the escaped branch with chase-branch.

```
$ git merge escaped
$ git verify
```

### Resolve a merge conflict

> Merge conflict appears when you change the same part of the same file differently in the two branches you're merging together. Conflicts require developer to solve them by hand.
> 
> Your repository looks like this:
> ```
>         HEAD
>          |
>     merge-conflict
>          |
> A <----- B
>  \
>   \----- C
>          |
> another-piece-of-work
> ```
> 
> 
> You want to merge the another-piece-of-work into your current branch. This will cause a merge conflict which you have to resolve. Your repository should look like this:
> ```
>                  HEAD
>                   |
>              merge-conflict
>                   |
> A <----- B <----- D
>  \               /
>   \----- C <----/
>          |
> another-piece-of-work
> ```

First we try to merge the two branches to cause merge conflict.

```
$ git branch --show-current
merge-conflict

$ git merge another-piece-of-work
Auto-merging equation.txt
CONFLICT (content): Merge conflict in equation.txt
Automatic merge failed; fix conflicts and then commit the result.
```

So we need to change `equation.txt` before merging them.

```
$ cat equation.txt 
<<<<<<< HEAD
2 + ? = 5
=======
? + 3 = 5
>>>>>>> another-piece-of-work
$ vim equation.txt 
$ cat equation.txt 
2 + 3 = 5
```

Now we can merge the two files.

```
$ git add .
$ git commit -m "resolve merge conflict in equation.txt"
[merge-conflict fc1ce64] resolve merge conflict in equation.txt

$ git verify
```

### Saving your work

> You are working hard on a regular issue while your boss comes in and wants you to fix a bug. State of your current working area is a total mess so you don't feel comfortable with making a commit now. However, you need to fix the found bug ASAP.
> 
> Git lets you to save your work on a side and continue it later. Find appropriate Git tool and use it to handle the situation appropriately.
> 
> Look for a bug to remove in bug.txt.
> 
> After you commit the bugfix, get back to your work. Finish it by adding a new line to bug.txt with
> 
> ```
> Finally, finished it!
> ```
> Then, commit your work after bugfix.

Use stashing to save the current work to background followed by a bug fix in `bug.txt`. Then pop the stash and do the next changes as given in instructions.

```
$ git stash
$ vim bug.txt # remove the buggy line
$ git commit -am "fix bug in bug.txt"
$ git stash pop
$ vim bug.txt # add the final text
$ git commit -am "update bug.txt"
$ git verify
```

### Change branch history

> ou were working on a regular issue while your boss came in and told you to fix recent bug in an application. Because your work on the issue hasn't been done yet, you decided to go back where you started and do a bug fix there.
> 
> Your repository look like this:
> ```
>         HEAD
>          |
> change-branch-history
>          |
> A <----- B
>  \
>   \----- C
>          |
>      hot-bugfix
> ```
> Now you realized that the bug is really annoying and you don't want to continue your work without the fix you have made. You wish your repository looked like you started after fixing a bug.
> ```
>                  HEAD
>                   |
>          change-branch-history
>                   |
> A <----- C <----- B
>          |
>      hot-bugfix
> ```
> Achieve that.

Rebase the current branch on the top of the bugfix one.

```
$ git branch --show-current
change-branch-history

$ git rebase hot-bugfix
Successfully rebased and updated refs/heads/change-branch-history.
```

### Remove ignored file

> File ignored.txt is ignored by rule in .gitignore but is tracked because it had been added before the ignoring rule was introduced.
> 
> Remove it so changes in ignored.txt file are not tracked anymore.

Use `git rm` to remove files from a staged state.

```
$ git rm ignored.txt
$ git commit -m "remove ignored.txt"
$ git verify
```

### hange a letter case in the filename of an already tracked file

> You have committed a File.txt but then you realized the filename should be all lowercase: file.txt. Change the filename.

Use `git mv`.

```
$ git mv File.txt file.txt
$ git commit -m "change filename"
$ git verify
```

### Fix typographic mistake in the last commit

> You have committed file.txt but you realized you made a typo - you wrote wordl instead of world.
> 
> Edit previous commit so no one would realize you haven't checked the file before committing it.
> 
> Pay attention to the commit message, too!

Use `git commit --amend` to chnage the last commit message even if the changes were staged and commited already.

```
$ sed -i 's/wordl/world/g' file.txt
$ git add .
$ git commit --amend
$ git verify
```


### Forge the commit's date

> You should have finished your work a week ago. However, you had some more important things to do so you have committed the work just now.
> 
> As a git expert, change the date of the last commit. Don't be modest - make it look like it was committed in 1987!

After lurking for a while, I found [this](https://git-scm.com/docs/git-commit#Documentation/git-commit.txt-code--dateltdategtcode).

```
$ git commit --amend --date="1987-01-01"
$ git verify
```

### Fix typographic mistake in old commit

> While you were working you noticed a typographic error in file.txt - you wrote wordl instead of world.
> 
> Unfortunately, you have made another commit on top of the typo so simple git commit --amend is not enough.
> 
> Fix the typographic error by amending commit in history. Pay attention to the commit message, too!

Same as `fix-typo` but now we have to move to the second last commit. Using hint, we use the `git-rebase` in interactive mode and move to the second last commit and do the required changes.

```
$ git rebase -i HEAD~2
```

this will open this:

```
pick 8095c63 Add Hello wordl
pick 4e1c912 Further work on Hello world

# Rebase 98e6b86..4e1c912 onto 98e6b86 (2 commands)
#
# Commands:
# p, pick <commit> = use commit
...
```

change the `pick` to `edit` on line 1. This will let us access the file from that commit and fix the typo.

```
$ cat file.txt 
Hello wordl

$ sed -i 's/wordl/world/g' file.txt
$ cat file.txt
Hello world
```

Add the file to staging state and also fix the typo in commit message

```
$ git add file.txt 
$ git commit --amend
$ git rebase --continue
Auto-merging file.txt
CONFLICT (content): Merge conflict in file.txt
error: could not apply fd3d44e... Further work on Hello world
hint: Resolve all conflicts manually, mark them as resolved with
hint: "git add/rm <conflicted_files>", then run "git rebase --continue".
hint: You can instead skip this commit: run "git rebase --skip".
hint: To abort and get back to the state before "git rebase", run "git rebase --abort".
Could not apply fd3d44e... Further work on Hello world
```

Okay so we have some merge conflicts now.

```
$ cat file.txt 
<<<<<<< HEAD
Hello world
=======
Hello wordl
Hello world is an excellent program.
>>>>>>> 4e1c912 (Further work on Hello world)
$ vim file.txt # solve merge conflicts
```

After mixing the merge conflicts, we add it to staging state and then continue to rebase and submit the solution.

```
$ git add file.txt 
$ git rebase --continue
$ git verify
```