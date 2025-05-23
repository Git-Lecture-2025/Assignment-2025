## Lesson 1 
    `git start master`
## Lesson 2
    Commit will always included all the files in the staging area
    Hence, only 'add' one of the files to the staging area
    ```
    git add A.txt
    git commit -m "Add A.txt"
    ```
## Lesson 3
    As commit will always include all the files in the staging area, we must remove one of them
    So, `git reset` on one file will remove it from the staging area. 
    Thereafter, `git commit` will only commit the other remaining file in the staging area
    `git reset A.txt` 
    (A.txt unstaged, untracked)
    `git commit -m "Add B.txt, only one file"`
## Lesson 4 
    A `.gitignore` file containts the list of extensions and file names and directories which will be ignored for tracking by git
    So after creation of `.gitignore` file, we will see that the files which were previously showing up in untracked are now not shown by git
    Create a `.gitignore` file.
    Write 4 lines in it - *.o, *.exe, *.jar, libraries/
    Add and commit `.gitignore` and all other remaining files
    ```
    git add .
    git commit -m "Add .gitignore and .txt files"
    ```
## Lesson 5 
    We have two branches. We make sure we are on the main branch of the repo
    Go to the main branch 
    ```
    git checkout chase-branch
    git branch 
    ```
    To see find name of the branch whose commits will be merged
    `git merge` is used in the branch into which the other branch is to be merged. 
    So we run the command in the chase-branch
    Running the below command will merge the additional commits of the escaped branch into the current branch
    `git merge escaped`
## Lesson 6 
    In this too, we will run `git merge` in the main branch
    `git merge another-piece-of-work` : Then we get merge conflict
    The merge conflict can be resolved in the Merge Editor of VS Code
    We will click upon 'Accept Combination', which will give us - 2+3=5
    ```
    git add .
    git commit -m "Merge branch another-piece-of-work"
    ```
## Lesson 7 
    Our present work is not complete, yet important, so `git stash` will just save a snapshot
    Then we can make edits, commits after using `git stash`
    `git stash`
    Edit the BUG line in bug.txt using VSCode Editor (can use nano bug.txt for this too)
    ```
    git add .
    git commit -m "Fix bug in bug.txt"
    ```
    To bring back all the previous additional work we had 'stashed', we will run:
    `git stash pop`
    Add the "Finally, finished it!" line to bug.txt using VSCode Text Editor
    ```
    git add .
    git commit -m "Finish work on regular issue"
    ```
## Lesson 8 
    `git rebase` will be used to make this change.
    This command is quite similar to merge, but in rebase, all the commits of one branch are put before the other one
    This lesson has the exact usecase of rebase command
    git checkout to main branch, which is named change-branch-history (if not already on the branch)
    ```
    git checkout change-branch-history
    git rebase hot-bugfix
    ```
## Lesson 9 
    For this, we will use `git rm <-file_name->`. rm is used to remove files from the staging area and the working directory
    We don't want to remove it from the working directory
    Hence we add the `--cached flag`, which only removes it from the staging area, not the directory.
    ```
    git rm --cached ignored.txt 
    git commit -m "Make ignored.txt as untracked file"
    ```
## Lesson 10 
    We will use `git mv` instead of only mv (rename)
    `git mv <-file_name->` is basically three commands - 
        ```
        mv File.txt file.txt
        git add file.txt
        git rm File.txt
        ```
    ```
    git mv File.txt file.txt 
    git commit -m "Rename File.txt to file.txt"
    ```
## Lesson 11 
    `git log`
    We will see the commit messages. This way we know what the typo is in the commit message as well
    Then we modify the required typo in the `file.txt` using the text editor (`nano file.txt`, or in VS Code)
    Using the `--amend` flag in `git commit` allows to fix whatever was done in the previous commit without actually making a new commit
    ```
    git add file.txt
    git commit --amend --no-edit -m "Add Hello world" 
    ```
## Lesson 12 
    `git commit` allows us to edit the date in a selected commit
    We have to change the date in the latest commit
    Hence we only need to use the `--amend` and the `--date` flag on git commit to edit the latest commit
    ```
    git commit --amend --date "Thu May 22 18:33:51 1987 +0530"
    ```
## Lesson 13 
    `git log` - to check the logs
    `git reabse -i`
    The `-i` flag in rebase opens the interactive format `git rebase`
    Change the 'pick' to 'edit' keyword in the rebase interactive in the particular commit
    Now upon saving and running, it will stop at the commit with the edit keyword
    Edit the file
    ```
    git add .
    git commit --amend '-S' -m "Add Hello world"
    git rebase --continue
    ```
    Merge Conflict - Resolve in Merge Editor using accept combination
    `git rebase --continue`