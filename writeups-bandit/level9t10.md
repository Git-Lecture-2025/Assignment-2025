# Level 9 to 10 Solution

1. Login using:
    ```
    ssh bandit9@bandit.labs.overthewire.org -p 2220
    ```
2. Put the password you got from the previous level.
3. Use the following command:
    ```
        strings data.txt | grep ==
    ```
    * `strings` command prints the human readable characters of the file only.
    * `|` pipes the output of strings into `grep` command which searches for only the lines with the specified keywords. In our case , it's `==` or several **"="**.
4. You will get the password in those lines.