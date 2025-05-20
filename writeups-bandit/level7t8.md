# Level 7 to 8 Solution

1. Login using:
    ```
    ssh bandit7@bandit.labs.overthewire.org -p 2220
    ```
2. Put the password you got from the previous level.
3. Concatinate the `data.txt` file and pipe it through the command `grep millionth` as 
    ```
    cat data.txt | grep millionth
    ```
    * `|` pipes the output of one command as input into another command.
    * `grep` command prints out the line which contains the specified word after the **grep** word.