# Exercise - 6 Solution

1. Start the challenge by writing in your bash:

   `git start merge-conflict`

2. Write the code line in bash as :
    
    `git merge another-piece-of-work`
3. You will get a merge conflict and you will be notified that it's in equation.txt , so open equation.txt file in your text editor.
4. In the file, you will see both the content of equation.txt of branches **_merge-conflict_** and **_another-piece-of-work_** .
5. Compare the contents of both branches and resolve to a common content , in this case the solution is **"2 + 3 = 5"**.
6. Remove the special characters like `>>>>> `,`|||||| `,`=====` , and branch names.
7. Add the **_equation.txt_** to the stage by `git add equation.txt` and commit the change by `git commit -m "commit message"`.
8. `git verify` to complete the challenge.