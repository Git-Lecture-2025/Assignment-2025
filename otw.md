# Bandit: OverTheWire Writeups

### Level 0

> The goal of this level is for you to log into the game using SSH. The host to which you need to connect is bandit.labs.overthewire.org, on port 2220. The username is bandit0 and the password is bandit0. Once logged in, go to the Level 1 page to find out how to beat Level 1.

As said above login to the remote device using `ssh`.

```
$ ssh bandit0@bandit.labs.overthewire.org -p 2220
```

### Level 0 → Level 1

> The password for the next level is stored in a file called readme located in the home directory. Use this password to log into bandit1 using SSH. Whenever you find a password for a level, use SSH (on port 2220) to log into that level and continue the game.

Read `readme` to get the password for Level 2

```
bandit0@bandit:~$ ls
readme

bandit0@bandit:~$ cat readme
Congratulations on your first steps into the bandit game!!
Please make sure you have read the rules at https://overthewire.org/rules/
If you are following a course, workshop, walkthrough or other educational activity,
please inform the instructor about the rules as well and encourage them to
contribute to the OverTheWire community so we can keep these games free!

The password you are looking for is: ZjLjTmM6FvvyRnrb2rfNWOZOTa6ip5If
```

### Level 1 → Level 2

> The password for the next level is stored in a file called - located in the home directory

The problem with the filename `-` is that it is used to supply optional flags to a command. To disambiguate it from a flag, we can use the fullpath or relative path to the file.

```
$ ssh bandit1@bandit.labs.overthewire.org -p 2220

bandit1@bandit:~$ ls
-

bandit1@bandit: $ cat ~/-
263JGJPfgU6LtdEvgfWU1XP5yac29mFx
```

### Level 2 → Level 3

> The password for the next level is stored in a file called spaces in this filename located in the home directory

To solve this you can eiher use escape sequence or use "<filename>".

```
$ ssh bandit2@bandit.labs.overthewire.org -p 2220

bandit2@bandit:~$ ls
spaces in this filename

bandit2@bandit:~$ cat spaces\ in\ this\ filename 
MNk8KNH3Usiio41PRUEoDFPqfxLPlSmx

bandit2@bandit:~$ cat "spaces in this filename" 
MNk8KNH3Usiio41PRUEoDFPqfxLPlSmx
```

### Level 3 → Level 4

> The password for the next level is stored in a hidden file in the inhere directory.

Use `ls -al` to list all files (including hidden ones) in a directory.

```
$ ssh bandit3@bandit.labs.overthewire.org -p 2220

bandit3@bandit:~$ ls
inhere

bandit3@bandit:~$ cd inhere/
bandit3@bandit:~/inhere$ ls

bandit3@bandit:~/inhere$ ls -al
total 12
drwxr-xr-x 2 root    root    4096 Apr 10 14:23 .
drwxr-xr-x 3 root    root    4096 Apr 10 14:23 ..
-rw-r----- 1 bandit4 bandit3   33 Apr 10 14:23 ...Hiding-From-You

bandit3@bandit:~/inhere$ cat ...Hiding-From-You 
2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ
```

### Level 4 → Level 5

> The password for the next level is stored in the only human-readable file in the inhere directory. Tip: if your terminal is messed up, try the “reset” command.

Use `file` to view the filetype of a file.

```
$ ssh bandit4@bandit.labs.overthewire.org -p 2220

bandit4@bandit:~$ ls
inhere

bandit4@bandit:~$ cd inhere/

bandit4@bandit:~/inhere$ ls
-file00  -file01  -file02  -file03  -file04  -file05  -file06  -file07  -file08  -file09

bandit4@bandit:~/inhere$ file ./-file0*
./-file00: PGP Secret Sub-key -
./-file01: data
./-file02: data
./-file03: data
./-file04: data
./-file05: data
./-file06: data
./-file07: ASCII text
./-file08: data
./-file09: data

bandit4@bandit:~/inhere$ cat ./-file07
4oQYVPkxZOOEOO5pTW81FB8j8lxXGUQw
```

### Level 5 → Level 6

> The password for the next level is stored in a file somewhere under the inhere directory and has all of the following properties:human-readable;1033 bytes in size;not executable

```
bandit5@bandit:~$ ls
inhere

bandit5@bandit:~$ cd inhere/

bandit5@bandit:~/inhere$ ls
maybehere00  maybehere03  maybehere06  maybehere09  maybehere12  maybehere15  maybehere18
maybehere01  maybehere04  maybehere07  maybehere10  maybehere13  maybehere16  maybehere19
maybehere02  maybehere05  maybehere08  maybehere11  maybehere14  maybehere17

bandit5@bandit:~/inhere$ ls maybehere00
-file1  -file2  -file3  spaces file1  spaces file2  spaces file3
```

Listing the `inhere` directory gives a lot of other directories which further contains many files. So wee needto search them for a file with the above properties. Gladly our friend, `find` will help here.

```
bandit5@bandit:~/inhere$ find . -type f -size 1033c -readable ! -executable
./maybehere07/.file2

bandit5@bandit:~/inhere$ cat ./maybehere07/.file2
HWasnPhtq9AVKe0dmk45nxy20cvUa6EG
```
Breakdown:
- `-type f` looks for only files
- `-size 1033c` looks fr files with 1033 bytes 
- `! -executable` search for non-executable files (https://stackoverflow.com/questions/70539901/how-can-i-find-all-non-executable-files-in-a-directory-in-linux)

Alternatively you can also use `file` as in before, to check for readability.

```
bandit5@bandit:~/inhere$ find . -type f -size 1033c ! -executable | xargs file | grep "ASCII"
./maybehere07/.file2: ASCII text, with very long lines (1000)
```

### Level 6 → Level 7

> The password for the next level is stored somewhere on the server and has all of the following properties: owned by user bandit7;owned by group bandit6;33 bytes in size

Similar as above we can use the `find` command to search for the required files.

```
bandit6@bandit:~$ find / -type f -size 33c -user bandit7 -group bandit6
find: ‘/root’: Permission denied
find: ‘/proc/tty/driver’: Permission denied
find: ‘/proc/1932200/task/1932200/fdinfo/6’: No such file or directory
find: ‘/proc/1932200/fdinfo/5’: No such file or directory
find: ‘/boot/lost+found’: Permission denied
find: ‘/boot/efi’: Permission denied
find: ‘/etc/polkit-1/rules.d’: Permission denied
find: ‘/etc/sudoers.d’: Permission denied
find: ‘/etc/xinetd.d’: Permission denied
find: ‘/etc/credstore’: Permission denied
find: ‘/etc/multipath’: Permission denied
find: ‘/etc/ssl/private’: Permission denied
find: ‘/etc/credstore.encrypted’: Permission denied
find: ‘/etc/stunnel’: Permission denied
...
```

Uh, oh. That looks messy. Well we have some error messages (because we are trying to access some files which we don't have permissions to). To remove them redirect them to `/dev/null`.

```
bandit6@bandit:~$ find / -type f -size 33c -user bandit7 -group bandit6 2>/dev/null
/var/lib/dpkg/info/bandit7.password

bandit6@bandit:~$ cat /var/lib/dpkg/info/bandit7.password
morbNTDkSW6jIlUc0ymOdMaLnOlFVAaj
```
Here `2>/dev/null` means to redirect the `stderr` (file descriptor with value 2) to `/dev/null`.

### Level 7 → Level 8

> The password for the next level is stored in the file data.txt next to the word millionth

Use `grep`.

```
bandit7@bandit:~$ ls
data.txt

bandit7@bandit:~$ cat data.txt | grep millionth
millionth       dfwvzFQi4mU0wfNbFOe9RoWskMLg7eEc
```

### Level 8 → Level 9

> The password for the next level is stored in the file data.txt and is the only line of text that occurs only once.

We can use `sort` in conjuction with `uniq` to search for unique lines.

```
bandit8@bandit:~$ ls
data.txt

bandit8@bandit:~$ sort data.txt | uniq -u
4CKMh1JI91bUIZZPXDqGanal4xvAg0JM
```

`sort` first sorts the lines, then the `uniq` with the `-u` flags filters the unique lines.

### Level 9 → Level 10

> The password for the next level is stored in the file data.txt in one of the few human-readable strings, preceded by several ‘=’ characters.

We can use `strings` to display human-readable characters in the file. Pipe the output to `grep` to catch for `=`.

```
bandit9@bandit:~$ ls
data.txt

bandit9@bandit:~$ strings data.txt | grep =
,k=?
@k*=
========== the
#e=in
g+=ypF
ea=+
K>=*<
========== password{k
=========== is
1R=j/
e=<2g%
+G/YD=
=wDk
=3?lOt
========== FGUW5ilLVJrxX9kMYMmlN4MgbpfMiqey
```

### Level 10 → Level 11

> The password for the next level is stored in the file data.txt, which contains base64 encoded data

We can use some online decoder to decode the base64 string, but in most Unix like  systems have `base64` a tool for interacting with base64 strings.

```
bandit10@bandit:~$ ls
data.txt

bandit10@bandit:~$ cat data.txt 
VGhlIHBhc3N3b3JkIGlzIGR0UjE3M2ZaS2IwUlJzREZTR3NnMlJXbnBOVmozcVJyCg==

bandit10@bandit:~$ cat data.txt | base64 -d
The password is dtR173fZKb0RRsDFSGsg2RWnpNVj3qRr
```

### Level 11 → Level 12

> The password for the next level is stored in the file data.txt, where all lowercase (a-z) and uppercase (A-Z) letters have been rotated by 13 positions

Ahh, the classic ROT13. Here each letter is incremented by 13 positions, ie, `A` will be `N`, `B` will be `O`, `C` will be `P` and so on. Using `tr` will help us here.

```
bandit11@bandit:~$ ls
data.txt

bandit11@bandit:~$ cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'
The password is 7x16WNeHIi5YkIhWsfFIqoognUTyj9Q4
```

### Level 12 → Level 13

> The password for the next level is stored in the file data.txt, which is a hexdump of a file that has been repeatedly compressed. For this level it may be useful to create a directory under /tmp in which you can work. Use mkdir with a hard to guess directory name. Or better, use the command “mktemp -d”. Then copy the datafile using cp, and rename it using mv (read the manpages!)

Given a hexdump of a binary file we can generate the original binary file using `xxd` with the `-r` flag. Then we will use `file` command to determine the compression type and decompress it until we get a text file.

```
bandit12@bandit:~$ ls
data.txt

bandit12@bandit:~$ mktemp -d
/tmp/tmp.C9VMaIbsCe

bandit12@bandit:~$ cp data.txt /tmp/tmp.C9VMaIbsCe

bandit12@bandit:~$ cd /tmp/tmp.C9VMaIbsCe

bandit12@bandit:/tmp/tmp.C9VMaIbsCe$ mv data.txt dump

bandit12@bandit:/tmp/tmp.C9VMaIbsCe$ ls
dump

bandit12@bandit:/tmp/tmp.C9VMaIbsCe$ xxd -r dump rdump

bandit12@bandit:/tmp/tmp.C9VMaIbsCe$ file rdump 
rdump: gzip compressed data, was "data2.bin", last modified: Thu Apr 10 14:22:57 2025, max compression, from Unix, original size modulo 2^32 585

bandit12@bandit:/tmp/tmp.C9VMaIbsCe$ mv rdump data2.gz

bandit12@bandit:/tmp/tmp.C9VMaIbsCe$ gzip -d data2.gz 

bandit12@bandit:/tmp/tmp.C9VMaIbsCe$ ls
data2  dump

bandit12@bandit:/tmp/tmp.C9VMaIbsCe$ file data2
data2: bzip2 compressed data, block size = 900k

bandit12@bandit:/tmp/tmp.C9VMaIbsCe$ bzip2 -d data2
bzip2: Can't guess original name for data2 -- using data2.out

bandit12@bandit:/tmp/tmp.C9VMaIbsCe$ ls
data2.out  dump

bandit12@bandit:/tmp/tmp.C9VMaIbsCe$ file data2.out 
data2.out: gzip compressed data, was "data4.bin", last modified: Thu Apr 10 14:22:57 2025, max compression, from Unix, original size modulo 2^32 20480

bandit12@bandit:/tmp/tmp.C9VMaIbsCe$ mv data2.out data2.gz

bandit12@bandit:/tmp/tmp.C9VMaIbsCe$ gzip -d data2.gz 

bandit12@bandit:/tmp/tmp.C9VMaIbsCe$ ls
data2  dump

bandit12@bandit:/tmp/tmp.C9VMaIbsCe$ file data2 
data2: POSIX tar archive (GNU)

bandit12@bandit:/tmp/tmp.C9VMaIbsCe$ tar -xvf data2
data5.bin

bandit12@bandit:/tmp/tmp.C9VMaIbsCe$ ls
data2  data5.bin  dump

bandit12@bandit:/tmp/tmp.C9VMaIbsCe$ file data5.bin 
data5.bin: POSIX tar archive (GNU)

bandit12@bandit:/tmp/tmp.C9VMaIbsCe$ tar -xvf data5.bin
data6.bin

bandit12@bandit:/tmp/tmp.C9VMaIbsCe$ file data6.bin
data6.bin: bzip2 compressed data, block size = 900k

bandit12@bandit:/tmp/tmp.C9VMaIbsCe$ bzip2 -d data6.bin
bzip2: Can't guess original name for data6.bin -- using data6.bin.out

bandit12@bandit:/tmp/tmp.C9VMaIbsCe$ ls
data2  data5.bin  data6.bin.out  dump

bandit12@bandit:/tmp/tmp.C9VMaIbsCe$ file data6.bin.out 
data6.bin.out: POSIX tar archive (GNU)

bandit12@bandit:/tmp/tmp.C9VMaIbsCe$ tar -xvf data6.bin.out
data8.bin

bandit12@bandit:/tmp/tmp.C9VMaIbsCe$ file data8.bin 
data8.bin: gzip compressed data, was "data9.bin", last modified: Thu Apr 10 14:22:57 2025, max compression, from Unix, original size modulo 2^32 49

bandit12@bandit:/tmp/tmp.C9VMaIbsCe$ mv data8.bin data8.gz

bandit12@bandit:/tmp/tmp.C9VMaIbsCe$ gzip -d data8.gz 

bandit12@bandit:/tmp/tmp.C9VMaIbsCe$ ls
data2  data5.bin  data6.bin.out  data8  dump

bandit12@bandit:/tmp/tmp.C9VMaIbsCe$ file data8
data8: ASCII text

bandit12@bandit:/tmp/tmp.C9VMaIbsCe$ cat data8
The password is FO5dwFsc0cbaIiH0h8J2eUks2vdTDwAn
```


### Level 13 → Level 14

> The password for the next level is stored in /etc/bandit_pass/bandit14 and can only be read by user bandit14. For this level, you don’t get the next password, but you get a private SSH key that can be used to log into the next level. Note: localhost is a hostname that refers to the machine you are working on

On the remote machine we have the following files:

```
bandit13@bandit:~$ ls -al
total 24
drwxr-xr-x  2 root     root     4096 Apr 10 14:22 .
drwxr-xr-x 70 root     root     4096 Apr 10 14:24 ..
-rw-r--r--  1 root     root      220 Mar 31  2024 .bash_logout
-rw-r--r--  1 root     root     3771 Mar 31  2024 .bashrc
-rw-r--r--  1 root     root      807 Mar 31  2024 .profile
-rw-r-----  1 bandit14 bandit13 1679 Apr 10 14:22 sshkey.private
```

To download the `sshkey.private` file we can use the `scp` utility.

```
$ scp -P 2220 bandit13@bandit.labs.overthewire.org:sshkey.private .
```

Using the private key, we login as `bandit14`.

```
$ ssh -i sshkey.private bandit14@bandit.labs.overthewire.org -p 2220
Permissions 0640 for 'sshkey.private' are too open.
It is required that your private key files are NOT accessible by others.
This private key will be ignored.
Load key "sshkey.private": bad permissions
bandit14@bandit.labs.overthewire.org's password:
```

Hmm, seems like we cannot use the private key now. Searching for `permissions too open ssh` lands us at [this](https://stackoverflow.com/questions/9270734/ssh-permissions-are-too-open). So we need to change the access permission for the private key.

```
$ chmod 600 sshkey.private 
$ ssh -i sshkey.private bandit14@bandit.labs.overthewire.org -p 2220

bandit14@bandit:~$ 

```

Nice. We are logged in now.

### Level 14 → Level 15

> The password for the next level can be retrieved by submitting the password of the current level to port 30000 on localhost.

From previous level we know that the password is at `/etc/bandit_pass/bandit14`. We submit it to the localhost at port 30000, we can use `netcat`

```
bandit14@bandit:~$ cat /etc/bandit_pass/bandit14 | nc localhost 30000
Correct!
8xCjnmgoKbGLhHFAZlGE5Tmu4M2tKJQo
```

### Level 15 → Level 16

> The password for the next level can be retrieved by submitting the password of the current level to port 30001 on localhost using SSL/TLS encryption.

Similar as before, we need to submit the current level password to the localhost but this time we need to use SSL encryption. To acheive this we can use `openssl` utility.

```
bandit15@bandit:~$ cat /etc/bandit_pass/bandit15
8xCjnmgoKbGLhHFAZlGE5Tmu4M2tKJQo

bandit15@bandit:~$ openssl s_client -connect localhost:30001 -quiet
Can't use SSL_get_servername
depth=0 CN = SnakeOil
verify error:num=18:self-signed certificate
verify return:1
depth=0 CN = SnakeOil
verify return:1
8xCjnmgoKbGLhHFAZlGE5Tmu4M2tKJQo
Correct!
kSkvUpMQ7lBYyCM4GBPvCvT1BfWRy0D
```


### Level 16 → Level 17

> The credentials for the next level can be retrieved by submitting the password of the current level to a port on localhost in the range 31000 to 32000. First find out which of these ports have a server listening on them. Then find out which of those speak SSL/TLS and which don’t. There is only 1 server that will give the next credentials, the others will simply send back to you whatever you send to it.

Okay, similar as before but need to scan some ports. Let's see if `nmap`, a network scanning tool, is installed on the system or not.

```
bandit16@bandit:~$ nmap --version
Nmap version 7.94SVN ( https://nmap.org )
Platform: x86_64-pc-linux-gnu
Compiled with: liblua-5.4.6 openssl-3.0.13 libssh2-1.11.0 libz-1.3 libpcre2-10.42 libpcap-1.10.4 nmap-libdnet-1.12 ipv6
Compiled without:
Available nsock engines: epoll poll select
```

Yep, it is. We'll use it to scan our network for the given port range.

```
bandit16@bandit:~$ nmap -sV localhost -p 31000-32000
Starting Nmap 7.94SVN ( https://nmap.org ) at 2025-05-25 10:41 UTC
Nmap scan report for localhost (127.0.0.1)
Host is up (0.00015s latency).
Not shown: 996 closed tcp ports (conn-refused)
PORT      STATE SERVICE     VERSION
31046/tcp open  echo
31518/tcp open  ssl/echo
31691/tcp open  echo
31790/tcp open  ssl/unknown
31960/tcp open  echo
```

So only 2 services use SSL and one of them is an echo server. So the only useful service is at 31790. 

```
bandit16@bandit:~$ cat /etc/bandit_pass/bandit16 | openssl s_client -connect localhost:31790 -quiet
Can't use SSL_get_servername
depth=0 CN = SnakeOil
verify error:num=18:self-signed certificate
verify return:1
depth=0 CN = SnakeOil
verify return:1
Correct!
-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEAvmOkuifmMg6HL2YPIOjon6iWfbp7c3jx34YkYWqUH57SUdyJ
imZzeyGC0gtZPGujUSxiJSWI/oTqexh+cAMTSMlOJf7+BrJObArnxd9Y7YT2bRPQ
Ja6Lzb558YW3FZl87ORiO+rW4LCDCNd2lUvLE/GL2GWyuKN0K5iCd5TbtJzEkQTu
DSt2mcNn4rhAL+JFr56o4T6z8WWAW18BR6yGrMq7Q/kALHYW3OekePQAzL0VUYbW
JGTi65CxbCnzc/w4+mqQyvmzpWtMAzJTzAzQxNbkR2MBGySxDLrjg0LWN6sK7wNX
x0YVztz/zbIkPjfkU1jHS+9EbVNj+D1XFOJuaQIDAQABAoIBABagpxpM1aoLWfvD
KHcj10nqcoBc4oE11aFYQwik7xfW+24pRNuDE6SFthOar69jp5RlLwD1NhPx3iBl
J9nOM8OJ0VToum43UOS8YxF8WwhXriYGnc1sskbwpXOUDc9uX4+UESzH22P29ovd
d8WErY0gPxun8pbJLmxkAtWNhpMvfe0050vk9TL5wqbu9AlbssgTcCXkMQnPw9nC
YNN6DDP2lbcBrvgT9YCNL6C+ZKufD52yOQ9qOkwFTEQpjtF4uNtJom+asvlpmS8A
vLY9r60wYSvmZhNqBUrj7lyCtXMIu1kkd4w7F77k+DjHoAXyxcUp1DGL51sOmama
+TOWWgECgYEA8JtPxP0GRJ+IQkX262jM3dEIkza8ky5moIwUqYdsx0NxHgRRhORT
8c8hAuRBb2G82so8vUHk/fur85OEfc9TncnCY2crpoqsghifKLxrLgtT+qDpfZnx
SatLdt8GfQ85yA7hnWWJ2MxF3NaeSDm75Lsm+tBbAiyc9P2jGRNtMSkCgYEAypHd
HCctNi/FwjulhttFx/rHYKhLidZDFYeiE/v45bN4yFm8x7R/b0iE7KaszX+Exdvt
SghaTdcG0Knyw1bpJVyusavPzpaJMjdJ6tcFhVAbAjm7enCIvGCSx+X3l5SiWg0A
R57hJglezIiVjv3aGwHwvlZvtszK6zV6oXFAu0ECgYAbjo46T4hyP5tJi93V5HDi
Ttiek7xRVxUl+iU7rWkGAXFpMLFteQEsRr7PJ/lemmEY5eTDAFMLy9FL2m9oQWCg
R8VdwSk8r9FGLS+9aKcV5PI/WEKlwgXinB3OhYimtiG2Cg5JCqIZFHxD6MjEGOiu
L8ktHMPvodBwNsSBULpG0QKBgBAplTfC1HOnWiMGOU3KPwYWt0O6CdTkmJOmL8Ni
blh9elyZ9FsGxsgtRBXRsqXuz7wtsQAgLHxbdLq/ZJQ7YfzOKU4ZxEnabvXnvWkU
YOdjHdSOoKvDQNWu6ucyLRAWFuISeXw9a/9p7ftpxm0TSgyvmfLF2MIAEwyzRqaM
77pBAoGAMmjmIJdjp+Ez8duyn3ieo36yrttF5NSsJLAbxFpdlc1gvtGCWW+9Cq0b
dxviW8+TFVEBl1O4f7HVm6EpTscdDxU+bCXWkfjuRb7Dy9GOtt9JPsX8MBTakzh3
vBgsyi/sN3RqRBcGU40fOoZyfAMT8s1m/uYv52O6IgeuZ/ujbjY=
-----END RSA PRIVATE KEY-----
```

This looks like an SSH key. We'll save it with the name sshkey-16.private

### Level 17 → Level 18

> There are 2 files in the homedirectory: passwords.old and passwords.new. The password for the next level is in passwords.new and is the only line that has been changed between passwords.old and passwords.new

To see the changes between two file, we use the `diff` command.

```
bandit17@bandit:~$ ls
passwords.new  passwords.old
bandit17@bandit:~$ diff passwords.new passwords.old
42c42
< x2gLTTjFwMOhQ8oWNbMN362QKxfRqGlO
---
> C6XNBdYOkgt5ARXESMKWWOUwBeaIQZ0Y

```

So here the 42nd line is changed aand the password is `x2gLTTjFwMOhQ8oWNbMN362QKxfRqGlO`.

### Level 18 → Level 19

> The password for the next level is stored in a file readme in the homedirectory. Unfortunately, someone has modified .bashrc to log you out when you log in with SSH.

This can be solved in a multiple of ways. One of the ways is to use `scp` to download the file locally and read it. Another involves executing command using `ssh`. 

```
$ scp -P 2220 bandit18@bandit.labs.overthewire.org:readme .
bandit18@bandit.labs.overthewire.org's password: 
readme                                                                      100%   33     0.2KB/s   00:00 

$ cat readme 
cGWpMaKXVwDUNgPAVJbWYuGHVn9zl3j8
```

or

```
$ ssh bandit18@bandit.labs.overthewire.org -p 2220 "/bin/bash"

bandit18@bandit.labs.overthewire.org's password: 
ls
readme
cat readme
cGWpMaKXVwDUNgPAVJbWYuGHVn9zl3j8
```

### Level 19 → Level 20

> To gain access to the next level, you should use the setuid binary in the homedirectory. Execute it without arguments to find out how to use it. The password for this level can be found in the usual place (/etc/bandit_pass), after you have used the setuid binary.

This one is pretty straightforward. Running the binary is the only thing needed.

```
bandit19@bandit:~$ ls
bandit20-do
bandit19@bandit:~$ ./bandit20-do 
Run a command as another user.
  Example: ./bandit20-do id
bandit19@bandit:~$ ./bandit20-do cat /etc/bandit_pass/bandit20
0qXahG8ZjOVMN9Ghs7iOWsCfZyXOUbYO
```

