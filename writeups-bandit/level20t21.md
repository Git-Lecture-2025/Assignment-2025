# Level 20 to 21 Solution

1. Login using:
    ```
    ssh bandit20@bandit.labs.overthewire.org -p 2220
    ```
2. Put the password you got from the previous level.
3. The home directory contains a executable named as `suconnect` which makes a connection to localhost with port number as specified to its argument. Then it reads a line of text from the connection and if it's equal to password of this current level then it gives the next password on that connection.
4. So, open a new terminal and login to the same server as previous terminal with same `bandit20` username.
5. Now, in the new terminal execute the following command:
    ```
    nc -l localhost 3232
    ```
    * `nc` makes the connection to any server.
    * `-l` makes the connection to listen to outputs from another connection as well.
    * `localhost (random port number)` -- you get the point.
6. Now, after it listens, input the password of the current level in this.
7. Move to the previous terminal and execute the executable with same port number as used with `nc` command as
    ```
    ./sudoconnect 3232
    ```
8. It will compare, then send the new password to the connection and you will get the password on the `nc` on new terminal.
9. Save the password.