# Level 16 to 17 Solution

1. Login using:
    ```
    ssh bandit16@bandit.labs.overthewire.org -p 2220
    ```
2. Put the password you got from the previous level.
3. To know which ports are listening/open , we use `nmap` command to map out the network, it gives a list of ports which are open/listening, use it as:
    ```
    nmap -p31000-32000 localhost    
    ```
    * `-p` lets you specify the specific port number or range of port numbers.
    * `localhost` to search on the localhost.
4. After getting the list , try out each port number you get to know if connects through **SSL/TLS** using one of the following:
    ```
        ncat --ssl localhost (port number)
    ```
    ```
        openssl s_client -connect localhost:(port number)
    ```
5. After finding the right , input the current password of the level and you will get a **_private rsa key_**.
6. Make a new directory in `/tmp` directory with any name of your choice and make a new file in that with any of **".key , .pem , .ppk , etc."** extensions.
7. Open it in your text editor and then paste the key.
8. To make it private and secure , use the following command:
    ```
    chmod 600 path/to/key_file
    ```
    * `chmod` is used to change the file permimssions.
    * `600` represents *read/write* for owner of file and no permissions for group/others.
9. **(To get the password for next level to store)** 
    * SSH login with *bandit17* username as:
        ```
        ssh -i path/to/key bandit17@bandit.labs.overthewire.org -p  2220
        ```
    * Concatinate the password file:
        ```
        cat /etc/bandit_pass/bandit17
        ```
