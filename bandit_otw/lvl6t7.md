# Level 6 to 7

1. Login and put password
```ssh bandit6@bandit.labs.overthewire.org -p 2220```
2. Use the following command
```find / -size 33c -user bandit7 -group bandit6```
    - `-user -group` : specifies the user and group which owns the file
    - `/` : used to search the whole root directory
3. Retrieve the password using `cat`