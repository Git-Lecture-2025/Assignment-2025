# Level 10 to 11 Solution

1. Login using:
    ```
    ssh bandit10@bandit.labs.overthewire.org -p 2220
    ```
2. Put the password you got from the previous level.
3. `ls` and `cat data.txt` to find that the content of "data.txt" is in base64 encoded text.
4. Use `base64 -d` command to decode the text.
5. Final command is:
    ```
    cat data.txt | base64 -d
    ```
    * `base64` determines that text is in "base64" format.
    * `-d` commands to decode that text in "base64".
6. Save the password you got.