
# Git-Exercises Writups

Writups for the 


## commit-one-file

The directory contains 2 files `A.txt` and `B.txt` . To commit only 1 file we can stage only the A.txt file by using

`git add A.txt`

and then making a commit

`git commit -m "one-file"`

FInall y verify that you have completed the stage

`git verify`


## commit-one-file-staged

Again the direcotry has `A.txt` and `B.txt` but this time both the files are staged. This can be checked by running `git status`

![[Pasted image 20250518170926.png]]


To unstage A.txt, use the following command:  `git restore --staged A.txt`

Now Commit the staged B.txt and verify using
```
git commit -m "commit-one-file-staged"
git verify
```


## ignore-them

create a .gitignore file with the following contents;

```
**/*.exe
**/*.o
**/*.jar
libraries/
```


## chase-branch

we need to rebase chase branch on to escaped so we first swtich to chase branch to `chase-branch` and then run `git rebase escaped` to rebase chase-branch onto escaped.

Now both `chase-branch` and `escaped` are in the same position in the worktree


## merge-conflict
Since we need to merge `another-piece-of-work` into `merge-conflict` branch we switch to the merge comflict branch and then run `git merge another-piece-of-work` . Now to resolve the merge conflict open up `equation.txt` using the text editor of your choice
```
<<<<<<< HEAD
2 + ? = 5
=======
? + 3 = 5
>>>>>>> another-piece-of-work
```

This is the contents of the equation.txt. Resolve this simply by chaning it to:
```
2 + 3 = 5
```

then stage the changes and commit
```
git add .
git commit -m "resolved merge conflicts"
```

Finally verify to move on to the next stage
```
git verify
```



## save-your-work

To save your current work run `git stash`
then fix the bug in `bug.txt` by removing the line 

```
THIS IS A BUG - remove the whole line to fix it.
```

Stage and commit the bug fix
```
git add .
git commit -m "bug fix"
```


Recover your work by running git stash apply . Finally add the line :
```    
Finally, finished it!
```

To the end of bug.txt. Stage, commit and verify to move to the next stage
```
git add .
git commit -m 'save-your-work'
git verify
```


## Change Branch History

Simple rebase of change-branch-hisotyr on the head of hot-bugfix will do since we need the tree to be lienarlized.

```
git checkout change-branch-history
git rebase hot-bugfix
```

Finally stage,commit and verify to move to the next stage

```
git add .
git commit -m "change-branch-history"
git verify
```


## remove-ignored

Since ignored.txt is being tracked we can tell git to stop tracking it by running:
```
git rm --cached ignored.txt
```

Finally stage,commit and verify to move on to the next stage
```
git add .
git commit -m "remove-ignored"
git verify
```


## case-sensitive-filename

To rename the file a simple `mv` command will not do. For instance if one does
`mv abcdef.txt ghijk.txt` then git assumes `abcdef.txt` got deleted and `ghijk.txt` got created but we don't want that. Instead we want git to recognize the rename.

Note: git runs rename detection for similar names. For instance renames like `File.txt`->`file.txt` gets registered as a rename even if the user uses the vanilla `mv` command.

So for this challenge either one of the commands will do:
`git mv File.txt file.txt`
`mv File.txt file.txt`

Finally stage,commit and verify to move to the next stage

```
git add .
git commit -m "case-sensitive-filename"
git verify
```


## fix-typo

In this challenge file.txt has a typo
Its contents is:
```
Hello wordl
```
Fix it using a text editor to:
```
Hello world
```

Finally stage the changes using `git add .`
Amend the previous commit by running:
```
git commit --amend
```

git then opens up a text editor to edit the commit message. Fix the typo in the commit message and save the file.
Finally verify to move on to the next stage
```
git verify
```


## forge-date

Use the following command the change the commit date of the latest commit
`git commit --amend --no-edit --date="Wed Mar 4 12:34 1987 +0100"`
Then `git verify` to move on to the next stage



## fix-old-typo

Since we have to change a commit that isn't the latest we need to use the rebase in interactive mode
`git rebase -i`
Git then opens up a text editor with the commits and commands for them. Change the `pick` command to an `edit` command next to the commit with the typo.

![[Pasted image 20250518192527.png]]

Save the file and exit. Now git will let you modify the contents of the file. Fix the type and stage it using
`git add file.txt`
Commit the changes using  `git commit -m "-S"` which will also let you modify the commit message. Modify the commit message by fixing the typo and exit the text editor.

Then run the following command to continue rebasing
`git rebase --continue`

Git then prompts you to fix merge conflicts with HEAD~1 and HEAD~2(The commit we just fixed)

Open up `file.txt` and fix the conflict to:

```
Hello world
Hello world is an excellent program.
```

To accept the fix for the merge conflict run `git add file.txt`

Then finally run `git rebase --continue` to finish rebasing

To verify and move on to the next stage run `git verify`






