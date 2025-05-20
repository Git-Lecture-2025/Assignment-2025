# Level 12 to 13 Solution

1. Login using:
    ```
    ssh bandit12@bandit.labs.overthewire.org -p 2220
    ```
2. Put the password you got from the previous level.
3. First make a temporary file in `/tmp` folder , as unzipping any file is not allowed in another user's folder directly. Do it using `mkdir /tmp/(your directory name)`
4. Now copy the file `data.txt` into that directory by the command `mv` as 
    ```
    mv data.txt /tmp/(your directory name)/data.txt
    ```
5. Now `data.txt` is in hexdump , so reverse the process of hexdump by `xxd` command as
    ```
    cat data.txt | xxd -r
    ```
    * `-r` reverses the hexdump process.
6. Check the type of file using `file (filename)` command.
7. It's said in the problem that the file is being compressed differently many times , so you will know how the latest compression is applied by `file` command , so :
    * If it's **"gzip"** compressed, use:
        ```
        mv data data.gz
        gzip -d data.gz
        ```
    * If it's **"bzip2"** compressed, use:
        ```
        mv data data.bz2
        bzip2 -d data.bz2
        ```
    * If it's **"POSIX tar archive (GNU)"** , then:
        ```
        mv data data.tar
        tar -xvf data.tar
        ```
    etc., you got the point , until it's file type is simply `ascii text`.
8. Then `cat filename` to get the required password.