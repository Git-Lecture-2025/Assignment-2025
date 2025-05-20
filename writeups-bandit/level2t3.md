# Level 2 to 3 Solution

1. Login using:
    ```
    ssh bandit2@bandit.labs.overthewire.org -p 2220
    ```
2. Put the password you got from the previous level.
3. The next password is in a file called `spaces in a filename`, now you can't directly concatinate a file with spaces in its name using its name in the command.
4. To overcome this , just put the filename in quotes as 
`cat "spaces in a filename"`.
5. This will read out your required  password.