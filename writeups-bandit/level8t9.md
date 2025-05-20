# Level 8 to 9 Solution

1. Login using:
    ```
    ssh bandit8@bandit.labs.overthewire.org -p 2220
    ```
2. Put the password you got from the previous level.
3. `ls` to find that it contains only `data.txt` file.
4. Now sort the data inside **data.txt** and pipe it through **uniq** command  using:
    ```
    sort data.txt | uniq -u
    ```
    * We sort data.txt because `uniq` command works by comparing the current line to only its previous and next line to mark as unique.
    * `-u` ensures to print only unique lines.
    * This will print our next password.