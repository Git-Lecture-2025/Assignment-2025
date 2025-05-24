# INSTRUCTIONS
You can start the next exercise by the command line
```code
git start next
``` 


# EXERCISE-01
```code
git start master
```
Then push a commit:
```code
git push origin master
```
And verify:
```code
git verify
```

# EXERCISE-02
In this exercise we must commit only one file.<br>
There are two files<br>
```A.txt ```<br>
```B.txt ```<br>
Answer:
```code
git add A.txt
git commit -m "Commit A.txt file"
```

# EXERCISE-03
In this exercise we have 2 staged files<br>
```A.txt```<br>
```B.txt```<br>
We must commit only one of them
Answer:
```code
git reset A.txt
git commit -m "Commit B.txt file"
```

# EXERCISE-04
In this exercise we must ignore the unncessary files with the extensions:<br>
```.exe```<br>
```.o```<br>
```.jar```<br>
```libraries/```<br>
We must create a <b>.gitignore</b> file and add all the files in this using:
```code
echo "text_to_Add" >> .gitignore
```
And then stage and commit the changes


# EXERCISE-05
You are currently on <b>chase-branch</b> branch which is 2 commits behind the <b>escaped</b> branch<br>
You must <b>merge</b> the branches so that they point to the same commit.
```code
git merge escaped
```

# EXERCISE-06
You must merge the branches. But that will give you a <b>merge-conflict</b>. <br>
You must solve the conflicts by editing the files by hand Using the commands:
```code
cat file.txt
echo "changes" >file.txt
```
Then after solving the conflict:
```code
git merge another-piece-of-work
```


# EXERCISE-07
You must save your current work somewhere and fix a previous bug .
You can do this using
```code
git stash
```
This saves your current work on side and not actually a commit <br>
so that you don't need to commit unnecessary work
Then you can fix your bug and then do 
```code
git stash pop
```
To bring back your work and then continue.


# EXERCISE-08
You basically want to change the order of a few commits in different branches<br>
This is really helpful to change the order of specific tasks which must be done previously.
You must use
```code
git rebase <branch>
```

# EXERCISE-09
A file was staged before it was added in ```.gitignore``` file.<br>
You must remove the file so that the changes doesn't affect other part of the project.
<br>
<br>
You can do that using 
```code
git rm ignored.txt
```

# EXERCISE-10
You must rename the file name to something else
<br>
You can do that using:
```code
git mv <oldname> <newname>
```

# EXERCISE-11
You must fix a typo in the previous commit <br>
You can do that by first fixing the error in the file and then <br>
```code
git commit --amend -m "Your new message"
```
This let's you edit your previous commit and it's message based on the current fix.

# EXERCISE-12
You must change the date of a commit.<br>
You can do that using 
```code
git commit --amend --no-edit --date="1987-08-03"
```
Here ```--no-edit``` means there is no change in the commit message <br>
Of that previous commit

# EXERCISE-13

You have to fix a typo error in the commit on top of which<br>
Several commits have been made.
You can do this using rebase in interactive mode.


