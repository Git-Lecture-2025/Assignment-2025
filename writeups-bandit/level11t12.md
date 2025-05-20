# Level 11 to 12 Solution

1. Login using:
    ```
    ssh bandit11@bandit.labs.overthewire.org -p 2220
    ```
2. Put the password you got from the previous level.
3. `ls` and `cat data.txt` to find that the content is in rot13 encoding.
4. Use the following command:
    ```
    cat data.txt  | tr 'A-Za-z' 'N-ZA-Mn-za-m'
    ```
    * `|` pipes the output of `cat data.txt` into `tr` command. 
    * `tr` command translates the given characters using the specified characters given next to it.
    * `'A-Za-z' 'N-ZA-Mn-za-m'` means translate 'A-Z' to 'N-ZA-M' and same for small alphabets.
5. Save the password you got.