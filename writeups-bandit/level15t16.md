# Level 15 to 16 Solution

1. Login using:
    ```
    ssh bandit15@bandit.labs.overthewire.org -p 2220
    ```
2. Put the password you got from the previous level.
3. In this challenge we have to submit the current level password to **localhost** on **_port_ 30001** but throught **SSL/TLS** connection which can be done using `openssl` command.
4. Use the following command:
    ```
    openssl s_client -connect localhost:30001
    ```
    * `openssl` for SSL/TLS layer.
    * `s_client` acts as SSL/TLS client to connect to a server for testing or information trading.
    * `-connect` species to which server/ip we have to connect.
    * `localhost:30001` is the server and port number.
5. Once the connection is made, input the current level password and you will get the next password.
5. **OR** you can use `ncat` command for the same purpose as:
    ```
    ncat --ssl localhost 30001
    ```
6. Save the password.