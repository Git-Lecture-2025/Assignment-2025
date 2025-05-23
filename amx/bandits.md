# Bandits Writeup - AMX

## Level 0
```
> ssh bandit0@bandit.labs.overthewire.org -p 2220
> cat readme
```

*Code* : ZjLjTmM6FvvyRnrb2rfNWOZOTa6ip5If
## Level 1
```
> ssh bandit1@bandit.labs.overthewire.org -p 2220
> cat ./-
```

*Code* : 263JGJPfgU6LtdEvgfWU1XP5yac29mFx
## Level 2
```
> ssh bandit2@bandit.labs.overthewire.org -p 2220
> cat "spaces in this filename"
```

*Code* : MNk8KNH3Usiio41PRUEoDFPqfxLPlSmx
## Level 3
```
> ssh bandit3@bandit.labs.overthewire.org -p 2220
> cd inhere
> ls -a
> cat ./...Hiding-From-You
```
*Code* : 2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ
## Level 4
```
> ssh bandit4@bandit.labs.overthewire.org -p 2220
> cd inhere
> ls -a
> cat ./...Hiding-From-You
```
*Code* : 4oQYVPkxZOOEOO5pTW81FB8j8lxXGUQw
## Level 5 -- redo
```
> ssh bandit5@bandit.labs.overthewire.org -p 2220
> cat $(find . -size 1033c)
```
*Code* : HWasnPhtq9AVKe0dmk45nxy20cvUa6EG
## Level 6
```
> ssh bandit6@bandit.labs.overthewire.org -p 2220
> find / -user bandit7 -group bandit6 -size 33c 2> /dev/null
```
*Code* : morbNTDkSW6jIlUc0ymOdMaLnOlFVAaj
## Level 7
```
> ssh bandit7@bandit.labs.overthewire.org -p 2220
> cat data.txt | grep "millionth"
```
*Code* : dfwvzFQi4mU0wfNbFOe9RoWskMLg7eEc
## Level 8 -- recap
```
> ssh bandit8@bandit.labs.overthewire.org -p 2220
> sort data.txt | uniq -u
```
*Code* : 4CKMh1JI91bUIZZPXDqGanal4xvAg0JM
## Level 9
I was getting a statement saying 'binary file matches' so probably it was considering the file as binary. Upon using the -a (--text) flag it solved the problem
```
> ssh bandit9@bandit.labs.overthewire.org -p 2220
> grep "==" -a data.txt
```
*Code* : FGUW5ilLVJrxX9kMYMmlN4MgbpfMiqey
## Level 10
```
> ssh bandit10@bandit.labs.overthewire.org -p 2220
> base64 -d data.txt
```
*Code* : dtR173fZKb0RRsDFSGsg2RWnpNVj3qRr
## Level 11
```
> ssh bandit11@bandit.labs.overthewire.org -p 2220
> cat data.txt | tr "[a-m][n-z][A-M][N-Z]" "[n-z][a-m][N-Z][A-M]"
```
*Code* : 7x16WNeHIi5YkIhWsfFIqoognUTyj9Q4
## Level 12
```
> ssh bandit11@bandit.labs.overthewire.org -p 2220
> xxd -r data.txt data1.txt
```
Now after i followed the following steps in a loop
1. check the file type
2. rename it to match the file type
3. use corresponing tool to unzip the file

*Code* : FO5dwFsc0cbaIiH0h8J2eUks2vdTDwAn
## Level 13
```
> ssh bandit13@bandit.labs.overthewire.org -p 2220
> ssh bandit14@bandit.labs.overthewire.org -i sshkey.private -p 2220
```

*Code* : MU4VWeTyJk8ROof1qqmcBPaLh7lDCPvS
## Level 14
```
> ssh bandit14@bandit.labs.overthewire.org -p 2220
> telnet localhost 30000
```

*Code* : 8xCjnmgoKbGLhHFAZlGE5Tmu4M2tKJQo
## Level 15
Ran ```openssl s_client -h``` to get the paramter syntax
```
> ssh bandit15@bandit.labs.overthewire.org -p 2220
> openssl s_client localhost:30001
```

*Code* : kSkvUpMQ7lBYyCM4GBPvCvT1BfWRy0Dx

## Level 16
```
> ssh bandit16@bandit.labs.overthewire.org -p 2220
> nmap -sV -T4 -p31000-32000 localhost
```
After this i got a list of all the ports in the range and the service they were running
```
> openssl s_client -connect localhost:31790
```
But i was getting KEYUPDATE as a response when i submitted the keys because the first letter of my key was "k" which was the command for keyupdate. Upon looking up the man page i found a flag -nocommand which let me get past this problem
```
> openssl s_client -nocommands -connect localhost:31790
```
On submitting the keys of the current level i got an ssh private key.
*KEY:*
```
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

I saved the keys on my local machine and tried connecting as bandit17 user. But the file didn't have enough permissions
```
> chmod 600 keyfile
> ssh bandit17@bandit.labs.overthewire.org -p 2220 -i keyfile
```
I was finally able to connect to level 17 after this.

## Level 17.
```
> diff passwords.new passwords.old
```

*Code* : x2gLTTjFwMOhQ8oWNbMN362QKxfRqGlO

## Level 18.
So as said in the question I can login to the system but i will be logged by the .bashrc script.
So i now i can use -t flag which allocates a pseudo terminal and i can run commands.
```
> ssh bandit18@bandit.labs.overthewire.org -p 2220 -t "cat ~/readme"
``` 

*Code* : cGWpMaKXVwDUNgPAVJbWYuGHVn9zl3j8

## Level 19.
Since the s bit was already any command which executed will be as if the owner executed it.

on running the binary it said we can run any command as the user bandit20
```
> ./bandit20-do cat /etc/bandit_pass/bandit20
```
*Code* : 0qXahG8ZjOVMN9Ghs7iOWsCfZyXOUbYO







