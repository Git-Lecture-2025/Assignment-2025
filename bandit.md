# L0->L1
Password `bandit0`

The password is in a file called `readme`, we can view the contents of `readme` using the `cat` command
```
cat readme
```

# L1->L2

Password `ZjLjTmM6FvvyRnrb2rfNWOZOTa6ip5If`

The character `-` is used for flags by commands, to correctly represent the file we can refer to the file using `./filename`

```
cat ./-
```

# L2->L3

Password `263JGJPfgU6LtdEvgfWU1XP5yac29mFx`

The password is in a file called `spaces in this filename`. To correctly refer to the file we can use quotes

```
cat "sapces in this filename"
```

# L3->L4

Password `MNk8KNH3Usiio41PRUEoDFPqfxLPlSmx`

The password is in a filename that is hidden, we can use the `-a` flag in `ls` command to list all the files

```
cd inhere
ls -a
cat ...Hiding-From-You
```

# L4->L5

Password `2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ`

The password is hidden in the only ASCII file, we can use the `file` command to check filetype of a file, to check for all files we can use wildcard `file0*` which will refer to all files that match that regex

```
file inhere/-file0*
cat inhere/-file07
```

# L5->L6

Password `4oQYVPkxZOOEOO5pTW81FB8j8lxXGUQw`

The password is in a file that has size of exactly 1033 bytes, we can use the `find` command with the `-size` flag to filter files which have exactly 1033 characters, and we also need the `-type` flag to only look for files, not directories

```
find . -size 1033c -type f
cat ./inhere/maybehere07/.file2
```

# L6->L7

Password `HWasnPhtq9AVKe0dmk45nxy20cvUa6EG`

The password is in a file that is owned by user `bandit7` and group `bandit6`, we can use the `-user` and  `-group` flag to filter for this, and to find for the file everywhere we find in the root directory `/`

```
find / -user bandit7 -group bandit6
cat /var/lib/dpkg/info/bandit7.password
```

# L7->L8

Password `morbNTDkSW6jIlUc0ymOdMaLnOlFVAaj`

The password is in the file `data.txt` next to the word `millionth`, we can use the `grep` command to extract the line which contains the word `millionth`

```
cat data.txt | grep millionth
```

# L8->L9

Password `dfwvzFQi4mU0wfNbFOe9RoWskMLg7eEc`

The password is the only string that appears only once in `data.txt`, we can use the `uniq` command with the `-u` flag to filter for unique matches.
According to man pages to uniq it only filters for unique matches that are adjacent, so we first sort them using the `sort` command, so that all the same entries are next to each other

```
cat data.txt | sort | uniq -u
```

# L9->L10

Password `4CKMh1JI91bUIZZPXDqGanal4xvAg0JM`

The password is in data.txt, since we know that the password is a valid ASCII string, we can filter for it using the `strings` command, and only get the lines which have `=` using the `grep` command

```
cat data.txt | strings | grep =
```

# L10->L11

Password `FGUW5ilLVJrxX9kMYMmlN4MgbpfMiqey`

The password is in data.txt in base64 format, we can decode this using the `base64` commad using the `--decode` flag and piping the base64 data to it

```
cat data.txt | base64 --decode
```

# L11->L12

Password `dtR173fZKb0RRsDFSGsg2RWnpNVj3qRr`

To get this password we need to apply the ROT13 cipher to data.txt, we can do this using the `tr` command, we specify the input array as `A-Z` and the output to be `N-ZA-M` which is `A-Z` shifted by 13, and the same for lowercase letters

```
cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'
```

# L12->L13

Password `7x16WNeHIi5YkIhWsfFIqoognUTyj9Q4`

For this challange we are given a data.txt which is a hexdump of a binary file, we can get back the binary file using `xxd`
Since we will need to create a file, we need a tmp directory, we can make one using the `mktmp` command

```
mktemp -d 
cat data.txt | xxd -r > /tmp/tmp.Dw30W38n4O/data
```

Now if we run `file` on this we see that this is a compressed gzip file, we will need to decompress this, after decompression we will find that the uncompressed file is also a compressed file, there are many levels of compressions applied of many types: `gzip` `bzip` `tar`

We run file on the compressed file to check its type and perform decompressions accordingly

For gzip
```
gzip -d compressed_file
```

For bzip2
```
bzip2 -d compressed_file
```

For tar
```
tar -xf compressed_file
```

and finally we get the password

# L13->L14

Password `FO5dwFsc0cbaIiH0h8J2eUks2vdTDwAn`

We are given a ssh key, we can use this key using the `-i` flag in ssh command

```
ssh bandit14@bandit.labs.overthewire.org -p 2220 -i sshkey.private
```

# L14->L15

Password `MU4VWeTyJk8ROof1qqmcBPaLh7lDCPvS`

For this level we are to send the password of this level to a server listening on port 30000, we can use netcat for this, anything we pipe into netcat will be sent to the server

```
echo MU4VWeTyJk8ROof1qqmcBPaLh7lDCPvS | nc localhost 30000
```

# L15->L16

Password `8xCjnmgoKbGLhHFAZlGE5Tmu4M2tKJQo`

For sending data to a server which uses SSL/TLS we can use openssl's `s_client`
```
echo 8xCjnmgoKbGLhHFAZlGE5Tmu4M2tKJQo | openssl s_client -connect localhost:30001 -ign_eof
```

# L16->L17

Password `kSkvUpMQ7lBYyCM4GBPvCvT1BfWRy0Dx`

For this level we need to find the port is between 31k-32k and has SSL, we can use the nmap command to scan all the ports, and use `--script` to filter for SSL only
```
nmap localhost -p 31000-32000 --script ssl-cert
echo kSkvUpMQ7lBYyCM4GBPvCvT1BfWRy0Dx | openssl s_client -connect localhost:31691 -ign_eof
```

We are given a ssh key, we can use this key using the following commands. We need to change the key's permissions because openssh will not use keys that are too accessible
```
chmod 600 rsakey
ssh bandit17@bandit.labs.overthewire.org -p 2220 -i rsakey
```

# L17->L18

Password `no password, use key to connect`

We are given 2 files, the password is the line that is different between the two files, we can use the `diff` command for this

```
diff passwords.new passwords.old
```
# L18->L19

Password `x2gLTTjFwMOhQ8oWNbMN362QKxfRqGlO`

Since the bashrc file will kickout the user as soon as they login we can execute a command without getting a shell using ssh as so:

```
ssh bandit18@bandit.labs.overthewire.org -p 2220 cat readme
```

# L19->L20

Password `cGWpMaKXVwDUNgPAVJbWYuGHVn9zl3j8`

We cannot normally access `/etc/bandit_pass/bandit20`, but we are given a script that can execute actions as `bandit_20` using the script given:

```
./bandit20-do cat /etc/bandit_pass/bandit20
```

