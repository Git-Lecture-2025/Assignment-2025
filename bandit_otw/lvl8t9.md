# Level 8 to 9

1. Login and put password
```ssh bandit7@bandit.labs.overthewire.org -p 2220```
2. Use the following command
```sort data.txt | uniq -u```
    - `uniq` : used to find unique or duplicate lines in a data
    - `-u` : this flag displays only the unique lines
    - `sort` : uniq requires sorted data to perform operation
    - `|` : piping
3. Save the password to login into next level