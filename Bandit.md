# Wargames Writups

bandit.labs.overthewire.org

### Level 0


```sh
ssh -p <port_number> <username>@<hostname>
```

Estblish a secure connection to a remote machine.

### Level 0 -> Level 1
```sh
cat <filename>
```
List the contents of a specific file. 

<details>
  <summary>Password</summary>
  ZjLjTmM6FvvyRnrb2rfNWOZOTa6ip5If
</details>

### Level 1 -> Level 2

```sh
cat > -
```

Since the file name is `-`

<details>
  <summary>Password</summary>
  263JGJPfgU6LtdEvgfWU1XP5yac29mFx
</details>

### Level 2 -> Level 3

```sh
cat "filename with spaces :D"
```

Since the required file name has spaces.

<details>
  <summary>Password</summary>
  MNk8KNH3Usiio41PRUEoDFPqfxLPlSmx
</details>

### Level 3 -> Level 4

```sh
ls -a
```

To show hidden files too

<details>
  <summary>Password</summary>
  2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ
</details>

### Level 5 -> Level 6

```sh
find . -type f -size <size> -exec file {} + | grep ASCII 
```

Execute file on each file in the current directory recursively of some size and pipe that into the input for grep to return all files of ASCII type.

<details>
  <summary>Password</summary>
  HWasnPhtq9AVKe0dmk45nxy20cvUa6EG
</details>

### Level 6 -> Level 7

```sh
find / -user <user> -group <group> -size <size>
```

Find all files from the root folder recursively that are owned by a particular user, group and of a particular size.

<details>
  <summary>Password</summary>
  morbNTDkSW6jIlUc0ymOdMaLnOlFVAaj
</details>

### Level 7 -> Level 8

```sh
cat <file> | grep <key>
```

Get the line with a prticular key on it in some file.

<details>
  <summary>Password</summary>
  dfwvzFQi4mU0wfNbFOe9RoWskMLg7eEc
</details>

### Level 8 -> Level 9

```sh
cat <file> | sort | uniq -u
```

Since uniq only checks for adjacent uniqueness, first sort the contents of the file

<details>
  <summary>Password</summary>
  4CKMh1JI91bUIZZPXDqGanal4xvAg0JM
</details>

### Level 9 -> Level 10

```sh
strings <file> | grep '^=+'
```

Gets all `strings` in a file that start with at least one `=`

<details>
  <summary>Password</summary>
  FGUW5ilLVJrxX9kMYMmlN4MgbpfMiqey
</details>

### Level 10 -> Level 11

```sh
cat <file> | base64 -d
```

Pipe the output of the file and decode it assuming its in base 64

<details>
  <summary>Password</summary>
  dtR173fZKb0RRsDFSGsg2RWnpNVj3qRr
</details>

### Level 11 -> Level 12

```sh
cat <file> | tr 'A-Za-z' 'N-ZA-Mn-za-m'
```

Perform EGB13 on the data of a file.

<details>
  <summary>Password</summary>
  7x16WNeHIi5YkIhWsfFIqoognUTyj9Q4
</details>

### Level 12 -> Level 13

Since the file is an original hexadecimal dump, un hex dump it:

```sh
xxd -r <file> > <output_file>
```

Now:

```sh
file <output_file>
```

The file type may be `gzip compressed data`, `bzip2 compressed data` or `POSIX tar archive`. Use the appropriate decompression command recusrively to obtain the password.

```sh
gzip -d 
bzip2 -D
tar -xf
```

<details>
  <summary>Password</summary>
  FO5dwFsc0cbaIiH0h8J2eUks2vdTDwAn
</details>

### Level 13 -> Level 14

```sh
ssh -i <private_key>
```

Establishes a connection with the known private key. Since the directory structure offered a private key, it could be used to establish a connection without the use of a password.

> Password: None

### Level 14 -> Level 15

```sh
echo "password" | nc localhost 30000
```

Echoes the password to port 30000 on the local machine.

<details>
  <summary>Password</summary>
  8xCjnmgoKbGLhHFAZlGE5Tmu4M2tKJQo
</details>

### Level 15 -> Level 16

```sh
openssl s_client -connect localhost:30001
```

Establishes a secure connection to port 30001 on the local machine 

<details>
  <summary>Password</summary>
  kSkvUpMQ7lBYyCM4GBPvCvT1BfWRy0Dx
</details>

### Level 16 -> Level 17

```sh
nmap -p31000-32000 localhost
```

Lists all ports that are listening.

```sh
openssl s_client -connect localhost:<port>
```

Can be used to check for SSL/TLS response. Add the `-quiet` flag if the password starts with `k`.

### Level 17 -> Level 18

```sh
diff <filea> <fileb>
```

Displays differences between the 2 files.

<details>
  <summary>Password</summary>
  x2gLTTjFwMOhQ8oWNbMN362QKxfRqGlO
</details>

### Level 18 -> Level 19

```sh
ssh -p <port> <username>@<hostname> "shell command"
```

SSH allows remote execution of commands which lets one bypass the logout from .bashsrc

<details>
  <summary>Password</summary>
  cGWpMaKXVwDUNgPAVJbWYuGHVn9zl3j8
</details>

### Level 19 -> Level 20

```sh
ls -al
```

Shows the setuid binary has the root user as bandit20 and group user as bandit19. So using the binary allows executing the `cat` command as bandit20.

```sh
./bandit20-do cat etc/bandit_pass/bandit20
```

Returns the required password

<details>
  <summary>Password</summary>
  0qXahG8ZjOVMN9Ghs7iOWsCfZyXOUbYO
</details>
