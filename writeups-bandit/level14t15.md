# Level 14 to 15 Solution

1. Login using:
    ```
    ssh bandit14@bandit.labs.overthewire.org -p 2220
    ```
2. Put the password you got from the previous level.
3. After being logged in grab the password on your clipboard by concatinating it from `/etc/bandit_pass/bandit14`.
4. Now connect to **_port_ 30000** of the **localhost** through `nc` command as:
    ```
    nc localhost 30000
    ```
5. After the connection is made, a blinking line cursor will show up waiting for input , here submit your copied password of this level and it will spit out password of next level as:
    ```
    (your current password)
    Correct!
    (next password)
    ```
6. Save the password.