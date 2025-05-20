# Level 4 to 5 Solution

1. Login using:
    ```
    ssh bandit4@bandit.labs.overthewire.org -p 2220
    ```
2. Put the password you got from the previous level.
3. To find the file with human readable data , use `file` as 
    ```
    file inhere/*
    ```
    * `*` to include all the files in the directory.
4. This will give file types of all the file in **inhere** directory, the one with **_ascii text_** means its in human readable form.
5. `cat inhere/(ascii file)` to get the next password.