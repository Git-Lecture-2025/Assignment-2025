# Exercise - 4 Solution

1. Start the challenge by writing in your bash:

   `git start ignore-them`

2. Make a .gitignore file by typing in your bash:
    `nano/vim .gitignore` depending on what text editor you use.
3. After the text editor being opened , write the following text:

    ```
        *.exe
        *.o
        *.jar
        libraries/
    ```
    to ignore the exe , o , jar files and libraries directory.

4. Now add the .gitignore to the stage by `git add .gitignore`
5. Commit the changes by `git commit -m "Add .gitignore file"`
6. Complete the challenge by `git verify`