# Level 17 to 18 Solution

1. Login using:
    ```
    ssh bandit17@bandit.labs.overthewire.org -p 2220
    ```
2. Put the password you got from the previous level.

## Or
1. Login using the rsa key from bandit16 user logged in the server:
    ```
    ssh -i path/to/key bandit17@bandit.labs.overthewire.org -p  2220
    ```
2.  Now two files (i.e `passwords.new` and `passwords.old`) are given which only differ by one line.
3. Use `diff` command which compares the given files line by line. So use this as:
    ```
    diff passwords.new passwords.old
    ```
4. You will get something like:
    ```
    42c42
    < x2gLTTjFwMOhQ8oWNbMN362QKxfRqGlO
    ---
    > C6XNBdYOkgt5ARXESMKWWOUwBeaIQZ0Y
    ```
    * The first line of random characters is the password as the first line is the different line in first argument of `diff` command (which is passwords.new) which is given.
5. Save the password.