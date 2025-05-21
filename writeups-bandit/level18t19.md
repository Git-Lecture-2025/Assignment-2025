# Level 18 to 19 Solution

1. Login using:
    ```
    ssh bandit18@bandit.labs.overthewire.org -p 2220
    ```
2. Put the password you got from the previous level, but this time it will automatically instantly log you off.
3. The reason for that the `.bashrc` has been modified to include a command to log the user off. (As `.bashrc` is the script which runs as soon as the user is (logged in)/started an interactive shell).
4. To overcome this , you can execute a command before `.bashrc` executes using the same ssh commmand. If you put a command at the end of normal login command of **ssh** it executes the trailing command before anything else.
5. For example, check the directory of the remote host using:
    ```
    ssh bandit18@bandit.labs.overthewire.org -p 2220 ls
    ```
    * `ls` is used at the end.
    * After putting in the password , you should see the `readme` ouput at the last.
6. So to get the next password just concatinate the *readme* file, using:
    ```
    ssh bandit18@bandit.labs.overthewire.org -p 2220 cat readme
    ```
7. Save the password.