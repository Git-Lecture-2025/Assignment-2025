1. Use `git stash` to save your current work and fix the bug
2. Resolve the bug in your text editor and commit changes.

   ```
   git add bug.txt
   git commit -m "fix bug"
   ```
3. Use `git stash apply` to continue your saved work
4. Add the required line to `bug.txt` and commit the changes