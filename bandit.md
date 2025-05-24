# LEVEL 0 -> 1
Figured out how to login using ssh:
```
ssh bandit0@bandit.labs.overthewire.org -p 2220
```
We put the password we got (bandit0) and successfully login! 
And used `cat` command to read contents of readme file to find the password of next level
```
cat readme
```
Password:ZjLjTmM6FvvyRnrb2rfNWOZOTa6ip5If

> **NOTE:** From here on we will use
> ```ssh banditx@bandit.labs.overthewire.org -p 2220```
> to login where `x` is the level we are loging into and using password from previous level unless stated otherwise in the solution


# LEVEL 1 -> 2
We have to specify full path of the file here while using cat, as its name is a special character.
```
cat ./-
```
Password: 263JGJPfgU6LtdEvgfWU1XP5yac29mFx


# LEVEL 2 -> 3
We need to put the file name in quotes as spaces are parsed as argument seperators without them.
```
cat "spaces in this filename"
```
Password: MNk8KNH3Usiio41PRUEoDFPqfxLPlSmx


# LEVEL 3 -> 4
We can use `find` inhere to find all files of inhere directory:
```
find inhere
```
We get two paths, one of them being the one we require.
```
cat inhere/...Hiding-From-You
```
Password:2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ


# LEVEL 4 -> 5
We again use `find` command to see the files.
```
 find inhere
```
We can use the `file` command to get more details about the file we specify:
```
file inhere/-file{00,01,02,03,04,05,06,07,08,09} 
```
Here `{}` are used to view all file details from 00-09 together
On reading through the details, we find that only file07 contains ASCII text hence we view its contents using `cat` command:
```
cat inhere/-file07
```
Password:4oQYVPkxZOOEOO5pTW81FB8j8lxXGUQw


# LEVEL 5 -> 6
We first go into inhere directory
```
cd inhere
```
The `find` command has flags `-type` and `-size` which can be used to find file of a certain type and size.
* `f` refers to regular files which we use to find human-readable
* `c` is used to refer to bytes and hence 1033 byte sized file found using 1033c
```
find -type f -size 1033c
```
The result is path to a singular file, we `cat` it to find its contents:
```
cat ./maybehere07/.file2
```
Password:HWasnPhtq9AVKe0dmk45nxy20cvUa6EG 


# LEVEL 6 -> 7
We need to find owned by particular user and group.
We use `find` as:
```
find / -size 33c -group bandit6 -user bandit7
```
* `-group` species the group which should own the file, which in our case is bandit6
* `-user` species the user who should own the file, which in our case is bandit7
* `/` path since we need to search the whole root directory
* `-size` to search 33 bytes file, where `c` is used for byte
It would result in only one path which we would concatinate using `cat` to find our paasword.  
```
cat /var/lib/dpkg/info/bandit7.password
```
Password:morbNTDkSW6jIlUc0ymOdMaLnOlFVAaj


# LEVEL 7 -> 8
We use `grep` which is used to search for lines matching a specified pattern in a file and print the matching lines, the specified pattern in our case being *'miilionth'*
```
grep millionth data.txt
```
Password:dfwvzFQi4mU0wfNbFOe9RoWskMLg7eEc


# LEVEL 8 -> 9
1. We use `sort`, which helps to sort lines of a file in a given order. Since we only care about unique lines and not the order we sort by default which alphabetical.
2. * `uniq` is used to delete all the repeated lines in a file, used with
   * `-u` it only outputs the unique line(s) in the file
3. `|` is used to redirect the output from one command as the input to the other command, in our case the output of `sort` which are sorted lines as the input to `uniq` command.
> **NOTE:** We need to `sort` first because duplicated lines must be adjacent for the `uniq` command to work as intended.
```
sort data.txt | uniq -u
```
Password:4CKMh1JI91bUIZZPXDqGanal4xvAg0JM


# LEVEL 9 -> 10
1. We use `strings` to find human readable text as it finds the printable strings in a file 
2. Redirect the output to `grep` using `|` and find pattern using `=+`, where `+` indicates any number of = signs in pattern
```
strings data.txt | grep =+
```
We can see the password near a bunch of '='.
Password:FGUW5ilLVJrxX9kMYMmlN4MgbpfMiqey


# LEVEL 10 -> 11
We use `base64` with `-d` to decode a base64 encoded string back to its original form 
```
base64 -d data.txt
```
Password:dtR173fZKb0RRsDFSGsg2RWnpNVj3qRr


# LEVEL 11 -> 12
rotated by 13
```
cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'
```
Password:7x16WNeHIi5YkIhWsfFIqoognUTyj9Q4


# LEVEL 12 -> 13
can find if a file is gzip compressed or bzip2 compressed using file or xxd and looking at the first 4 bytes
```
mktemp -d
cp data.txt /tmp/tmp.g8bZWTdXRJ
cd /tmp/tmp.g8bZWTdXRJ
mv data.txt temp
xxd -r temp > binary
file binary
mv binary binary.gz
gzip -d binary.gz
ls
file binary
bzip2 -d binary
file binary.out
mv binary.out binary.gz
gzip -d binary.gz
file binary
man tar
tar -xf binary
ls
tar -xf data5.bin
ls
file data6.bin
bzip2 -d data6.bin
file data6.bin.out
tar -xf data6.bin.out
ls
file data8.bin
mv data8.bin data8.gz
gzip -d data8.gz
file data8
cat data8
``` 
Password:FO5dwFsc0cbaIiH0h8J2eUks2vdTDwAn


# LEVEL 13 -> 14

given a private key , stored it and used it to login to nexr level

Password:MU4VWeTyJk8ROof1qqmcBPaLh7lDCPvS


# LEVEL 14 -> 15
```
nano bandit14_keys
```
store the key and
```
ssh -i '~/bandit14_keys' bandit14@bandit.labs.overthewire.org -p 2220
cd  /etc/bandit_pass
cat bandit14
```
```
nc localhost 30000

```
submitted the password and got new password

Password:8xCjnmgoKbGLhHFAZlGE5Tmu4M2tKJQo


# LEVEL 15 -> 16
openssl s_client is used for testing ssl/tls connection
```
openssl s_client localhost:30001
```
Password:kSkvUpMQ7lBYyCM4GBPvCvT1BfWRy0Dx


# LEVEL 16 -> 17
```
nmap -p31000-32000 localhost
```
```
PORT      STATE SERVICE
31046/tcp open  unknown
31518/tcp open  unknown
31691/tcp open  unknown
31790/tcp open  unknown
31960/tcp open  unknown
```
checked each port one by one using
```
openssl s_client -connect -nocommands localhost:31046
openssl s_client -connect -nocommands localhost:31518
openssl s_client -connect -nocommands localhost:31691
openssl s_client -connect -nocommands localhost:31790
```
got a rsa key & stored it


# LEVEL 17 -> 18
diff used for finding difference in content of two files
```
diff passwords.old passwords.new
```
Password:x2gLTTjFwMOhQ8oWNbMN362QKxfRqGlO


# LEVEL 18 -> 19
executing a command as soon as entering the password
```
ssh bandit18@bandit.labs.overthewire.org -p 2220 cat readme
```
Password:cGWpMaKXVwDUNgPAVJbWYuGHVn9zl3j8


# LEVEL 19 -> 20
used to script to access the bandit20 file
```
./bandit20-do cat /etc/bandit_pass/bandit20
```
Password:0qXahG8ZjOVMN9Ghs7iOWsCfZyXOUbYO


