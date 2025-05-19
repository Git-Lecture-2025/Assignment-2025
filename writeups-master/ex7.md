# Exercise - 7 Solution

1. Start the challenge by writing in your bash:

   `git start save-your-work`
2. Write `git stash` to stash your current in-work progress and move back to previous commit where bug fix is required.
3. Open **_bug.txt_** in your text-editor , there you just have to remove one line which states to remove that line for bug fix.
4. Now, 
    ```
    git add bug.txt
    git commit -m "fix(bug.txt)"
    ```
    to commit the bug-fix.
5. `git stash pop` or `git stash apply` to bring back your unfinished work.
6. Type the command `echo "Finally, finished it!" >> bug.txt` to add the required line in bug.txt to finish your work.
7.  ```
    git add bug.txt
    git add program.txt
    git commit -m "finish the work"
    ```
    to commit the final work.
8. Lastly , `git verify` to complete the challenge. 