# Exercise - 3 Solution

1. Start the challenge by writing in your bash:

   `git start commit-one-file-staged`

2. Check files by `ls` and  `git status` to see which files are present in staging area in the directory.

3. Then remove one of the files from the stage using:

    `git restore --staged A.txt` 
    or 

    `git restore --staged B.txt`
4. Check again using `git status`
5. Then commit using: `git commit -m "Add only ony file"`
6. Lastly, `git verify` to pass the challenge