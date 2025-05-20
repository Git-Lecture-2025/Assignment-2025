# Level 5 to 6 Solution

1. Login using:
    ```
    ssh bandit5@bandit.labs.overthewire.org -p 2220
    ```
2. Put the password you got from the previous level.
3. Use the following command
    ```
    find inhere/ -readable -size 1033c ! -executable
    ```
    * `-readable` finds the human readable files.
    * `-size` takes specified size to find for a file.
    * `! -executable` checks that file is not executable.
    
    This should find the required file.
4. Concatinate the required file for the next password.