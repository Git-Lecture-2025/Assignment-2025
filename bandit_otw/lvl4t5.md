# Level 4 to 5

1. Login and put password
```ssh bandit4@bandit.labs.overthewire.org -p 2220```
2. We need to find the only human-readable file

```find ~ -type f -exec file {} + | grep ASCII```
    - `find ~` : finds all the files and directories in root and subdirectories
    - `-type f` : restricts search to files only
    - `-exec file {} +` : executes this file command on all the files, {} is just a placeholder for file path
    - `grep ASCII` : filters the files which have ASCII type data
3. Now we know the correct file and can easily retrieve the paassword using `cat`