# LEVEL 0 -> 1
found how to login using ssh
```
ssh bandit0@bandit.labs.overthewire.org -p 2220
```
used to cat to read contents of readme
```
cat readme
```
Password:ZjLjTmM6FvvyRnrb2rfNWOZOTa6ip5If


# LEVEL 1 -> 2
have to specify full path as it is a special character
```
cat ./-
```
Password: 263JGJPfgU6LtdEvgfWU1XP5yac29mFx


# LEVEL 2 -> 3
need to put it in quotes as spaces are parsed as argument seperators 
```
cat "spaces in this filename"
```
Password: MNk8KNH3Usiio41PRUEoDFPqfxLPlSmx


# LEVEL 3 -> 4
```
find inhere
```
got two paths 
```
cat inhere/...Hiding-From-You
```
Password:2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ


# LEVEL 4 -> 5
```
 find inhere
```
```
file inhere/-file{00,01,02,03,04,05,06,07,08,09} 
```
used {} to view all file details together
only file07 contains ASCII text
```
cat inhere/-file07
```
Password:4oQYVPkxZOOEOO5pTW81FB8j8lxXGUQw


# LEVEL 5 -> 6
```
cd inhere
```
used -type f to find human-readable files -sizes to find 1033 byte sized files (c)
```
find -type f -size 1033c
```
found it
```
cat ./maybehere07/.file2
```
Password:HWasnPhtq9AVKe0dmk45nxy20cvUa6EG 


# LEVEL 6 -> 7
```
find / -size 33c -group bandit6 -user bandit7
```
-group to find owned by bandit6 group and -user to find owned by bandit7 user
```
cat /var/lib/dpkg/info/bandit7.password
```
Password:morbNTDkSW6jIlUc0ymOdMaLnOlFVAaj


# LEVEL 7 -> 8
looking for millionth using grep
```
grep millionth data.txt
```
Password:dfwvzFQi4mU0wfNbFOe9RoWskMLg7eEc


# LEVEL 8 -> 9
sorted the data using sort and gave that input to used uniq with -u flag to get only the unique line
```
sort data.txt | uniq -u
```
Password:4CKMh1JI91bUIZZPXDqGanal4xvAg0JM


# LEVEL 9 -> 10
found human readable text using strings and gave it to grep to find pattern using =+ '+' indication any number of = signs in pattern
```
strings data.txt | grep =+
```
Password:FGUW5ilLVJrxX9kMYMmlN4MgbpfMiqey

# LEVEL 10 -> 11
used base64 with -d (decode)
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


