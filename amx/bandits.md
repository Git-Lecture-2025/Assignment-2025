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
## Level 5 
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
## Level 8 
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



