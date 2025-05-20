# Level 6 to 7 Solution

1. Login using:
    ```
    ssh bandit6@bandit.labs.overthewire.org -p 2220
    ```
2. Put the password you got from the previous level.
3. Use the following command:
    ```
    find / -user bandit7 -group bandit6 -size 33c
    ```
    * `-user` can specify which user own the file to be found.
    * `-group ` specifies the group which owns the file to be found.
    * `-size ` specifies the size of the file.
    * `/` is used to search the whole root directory
4. After you get the file path and name , concatinate it using `cat path-of-the-file` to get the next password.