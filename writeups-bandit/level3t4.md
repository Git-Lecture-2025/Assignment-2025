# Level 3 to 4 Solution

1. Login using:
```
ssh bandit3@bandit.labs.overthewire.org -p 2220
```
2. Put the password you got from the previous level.
4. There is a hidden file in `inhere` directory , so to find its name use
    ```
    ls -a inhere/
    ```
    * `-a` lets you see hidden files as well (starting with "." in their names)
5. Then just `cat inhere/(your hidden file name)` to get the next password.