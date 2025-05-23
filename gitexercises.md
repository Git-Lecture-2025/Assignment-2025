## Lesson 1 
    git start master
## Lesson 2
    git add A.txt
    git commit -m "Add A.txt"
## Lesson 3
    git reset A.txt 
    (A.txt unstaged, untracked)
    git commit -m "Add B.txt, only one file"
## Lesson 4 
    Create a .gitignore file.
    Write 4 lines in it - *.o, *.exe, *.jar, libraries/
    Add and commit gitignore and all other remaining files
    git add .
    git commit -m "Add .gitignore and .txt files"
## Lesson 5 
    Go to the main branch 
    git checkout chase-branch
    git branch 
    To see find name of the branch whose commits will be merged
    git merge escaped
## Lesson 6 
    git merge another-piece-of-work : Then we get merge conflict
    resolve in merge editor in VS Code
    Accept Combination
    git add .
    git commit -m "Merge branch another-piece-of-work"
## Lesson 7 
    git stash
    Edit the BUG line in bug.txt using VSCode Editor
    git add .
    git commit -m "Fix bug in bug.txt"
    git stash pop
    Add the "Finally, finished it!" line to bug.txt using VSCode Text Editor
    git add .
    git commit -m "Finish work on regular issue"
## Lesson 8 
    git checkout to main branch, which is named change-branch-history
    git rebase hot-bugfix
## Lesson 9 
    git rm --cached ignored.txt 
    The --cached ensures that file is not entirely deleted from storage
    git commit -m "Make ignored.txt as untracked file"
## Lesson 10 
    git mv File.txt file.txt 
    It automatically does three steps - renames, rm File.txt, add file.txt - We only need to commit
## Lesson 11 
    git log
    To see the commit messages and see the typo
    git add file.txt 
    (After modifying the typo in the file)
    git commit --amend --no-edit -m "Add Hello world" 
## Lesson 12 
    git commit --amend --date "Thu May 22 18:33:51 1987 +0530"
## Lesson 13 
    git log - to check the logs
    git reabse -i
    To open the interactive rebase
    change the 'pick' to 'edit' keyword in the rebase interactive
    Now upon saving and running, it will stop at the older commit
    Edit the file
    git add .
    git commit --amend '-S' -m "Add Hello world"
    git rebase --continue
    Merge Conflict - Resolve in Merge Editor using accept combination
    git rebase --continue