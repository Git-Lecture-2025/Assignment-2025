# Level 13 to 14 Solution

1. Login using:
    ```
    ssh bandit13@bandit.labs.overthewire.org -p 2220
    ```
2. Put the password you got from the previous level.
3. Now you are given `sshkey.private` which is the private key to login to the server under the username `bandit14` using ssh as the password for next level is accesible only through the user **"bandit14"**.
4. So use the **_ssh_** command as:
    ```
    ssh -i sshkey.private bandit14@bandit.labs.overthewire.org -p 2220
    ```
    * `-i` allows to take private key to login into the server corresponding to the user. It takes the path to **_private key_** as argument.
5. After being logged in as **bandit14** , just concatinate the password from the file path mentioned in the problem which is **/etc/bandit_pass/bandit14** as `cat /etc/bandit_pass/bandit14`.
6. Save the password you got.